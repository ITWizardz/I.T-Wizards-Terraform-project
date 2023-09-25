terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  cloud {
    organization = "WMCA-2023"

    workspaces {
      name = "Aws_approval_project"
    }
  }
}

# Define EC2 instance and security group
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ami_number.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  key_name = "aws_docshare"
  connection {

    type = "ssh"

    user = "ec2-user"

    private_key = data.vault_generic_secret.secret.data["ssh_access"]

    host = self.public_ip

  }
  provisioner "remote-exec" {

    inline = [

      "sudo yum update -y",

      "sudo yum upgrade -y",

      "sudo yum install nginx -y",

      "sudo systemctl start nginx",

      "apt install openjdk-17-jdk openjdk-17-jre",
      "sudo apt install tomcat9",
      "sudo systemctl start tomcat9",
      "sudo systemctl enable tomcat9",

      "sudo apt-get install -y git",
      "sudo git clone ${webapp_repo} /var/lib/tomcat9/webapps"

    ]
  }

  tags = {
    Name        = "Web Server"
    Environment = lower(var.is_dev) == "yes" ? "Dev" : "Production"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Security group for web server"

  dynamic "ingress" {
    for_each = var.ports_list
    content {
      description = ingress.value.name
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [var.cidr_block_for_ingress]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_block_for_ingress]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Define an RDS database instance
resource "aws_db_instance" "mysql_db" {
  allocated_storage    = var.db_allocated_storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_type
  identifier           = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

# Define output for the RDS endpoint
/*output "mysql_endpoint" {
  value = aws_db_instance.mysql_db
}*/
