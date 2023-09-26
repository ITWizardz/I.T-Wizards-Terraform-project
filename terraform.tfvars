is_dev        = "yes"
the_region    = "eu-west-1"
instance_ami  = "ami-057b6e529186a8233" # Replace with your desired AMI ID
instance_type = "t2.micro"              # Change to your desired instance type

webapp_repo = "https://github.com/ITWizardz/test-webapp.git"

vault_address = "https://vault-cluster-public-vault-98265e65.ea7c76de.z1.hashicorp.cloud:8200"
vault_token = "hvs.CAESINMGZ0E1xbpVjYVM5aBxP6mTLlGU5q21PfVFi2M-Kx9sGicKImh2cy5kM3hyYnZMRjVqbzFUd0txa2FteW50eGouRkNnMWEQ-lo"

db_allocated_storage = 20            # Change as needed
db_instance_type     = "db.t2.micro" # Change as needed
db_name              = "testdb"
db_username          = "dev_user"           # Change as needed
db_password          = "dev_user_pass_123!" # Change as needed

ports_list = {
  http = {
    name     = "http",
    port     = 80,
    protocol = "tcp"
  },
  tomcat = {
      name     = "tomcat",
      port     = 8080,
      protocol = "tcp"
    },
  https = {
    name     = "https",
    port     = 443,
    protocol = "tcp"
  },
  ssh = {
    name     = "ssh",
    port     = 22,
    protocol = "tcp"
  }
}