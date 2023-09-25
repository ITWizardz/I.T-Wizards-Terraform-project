variable "secret_key" {
  description = "value"
  type        = string
}

variable "access_key" {
  description = "value"
  type        = string
}

variable "is_dev" {
  description = "Is this a dev build? (yes/no)"
  type        = string
  default     = "yes"
}

variable "the_region" {
  description = "Selected region"
  default     = "eu-west-1"
}

variable "cidr_block_for_ingress" {
  description = "Cidr block for the ingress"
  default     = "0.0.0.0/0"
}

variable "ports_list" {
  description = "Map of ports to open"
  type = map(object({
    name     = string
    port     = number
    protocol = string
  }))
  default = {
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
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}

#MYSQL DATABASE
variable "db_allocated_storage" {
  description = "The allocated storage for the RDS database (in GB)"
  type        = number
}

variable "db_instance_type" {
  description = "The RDS instance type"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}
