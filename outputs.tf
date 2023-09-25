output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}

/* output "vault_secret_stuff" {
   value     = data.vault_generic_secret.instance_size_demo.data["instancesize_dev"]
   sensitive = true
}*/


