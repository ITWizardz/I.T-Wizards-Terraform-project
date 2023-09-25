is_dev              = "yes" 
the_region          = "eu-west-1"
instance_ami        = "ami-057b6e529186a8233" # Replace with your desired AMI ID
instance_type       = "t2.micro"                # Change to your desired instance type
access_key          = "AKIATSXB26MEDTHTVND7"
secret_key          = "iqy3AUVPgSDjYaRVRvvi1+a+PVdf2yYV5+62IPx9"

db_allocated_storage = 20 # Change as needed
db_instance_type    = "db.t2.micro" # Change as needed
db_name             = "testdb"
db_username         = "dev_user" # Change as needed
db_password         = "dev_user_pass_123!" # Change as needed

ports_list = {
    http = {
      name     = "http",
      port     = 80,
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