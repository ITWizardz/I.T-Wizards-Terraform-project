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

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Security group for web server"

  dynamic "ingress" {
    for_each = var.ports_list
    content {
      description = ingress.value.nam
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

# Define output for the RDS endpoint
/*output "mysql_endpoint" {
  value = aws_db_instance.mysql_db
}*/
