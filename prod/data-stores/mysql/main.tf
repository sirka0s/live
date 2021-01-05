provider "aws" {
    region = "us-east-1"
}

#Configuring backend for tfstate file
terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "prod/data-stores/mysql/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

#Configuring RDS database
resource "aws_db_instance" example {
    identifier_prefix   = "terraform-prod"
    engine              = "mysql"
    allocated_storage   = 10
    instance_class      = "db.t2.micro"
    name                = "prod_database"
    username            = "admin"
    password            = var.db_password
}