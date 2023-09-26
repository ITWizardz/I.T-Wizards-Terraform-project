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

      # Update & Upgrade package library
      "sudo yum update -y",
      "sudo yum upgrade -y",

      # Java 17 install
      "wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm",
      "sudo yum -y install ./jdk-17_linux-x64_bin.rpm",

      # Install and run Maven
      "sudo yum install -y maven",

      # Install git and clone the webapp repo
      "sudo yum install -y git",
      "cd /var/lib/tomcat9/webapps",
      "sudo git clone ${var.webapp_repo}",
      
      # Fix permissions for Maven
      "sudo chown -R ${aws_instance.web_server.connection.user} test-webapp/target",
      "sudo chmod -R u+w test-webapp/target",

      "cd test-webapp",
      "nohop mvn spring-boot:run"
    ]
  }

  tags = {
    Name        = "Web Server"
    Environment = lower(var.is_dev) == "yes" ? "Dev" : "Production"
  }
}
