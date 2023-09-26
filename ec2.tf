# Define EC2 instance and security group
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ami_number.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  key_name = "aws_docshare"
  connection {

    type = "ssh"

    user = "ec2-user"
    # private_key = file("/Users/binoymaster/Downloads/ssh_approval/aws_docshare.pem")#data.vault_generic_secret.secret.data["ssh_access"]
    private_key = data.vault_generic_secret.secret.data["ssh_key_value"]
    host = self.public_ip

  }


  provisioner "remote-exec" {

    inline = [

      "sudo yum update -y",

      "sudo yum upgrade -y",

      "sudo yum install openjdk-17-jdk", # openjdk-17-jre
      "sudo yum install tomcat9",

      "sudo systemctl start tomcat9",

      "sudo systemctl enable tomcat9",

      "sudo yum install -y git",

      "sudo git clone ${var.webapp_repo} /var/lib/tomcat9/webapps",
        
      "sudo yum install -y maven",

      "mvn spring-boot:run"
    ]
  }

  tags = {
    Name        = "Web Server"
    Environment = lower(var.is_dev) == "yes" ? "Dev" : "Production"
  }
}
