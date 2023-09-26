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