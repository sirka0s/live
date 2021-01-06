provider "aws" {
    region = "us-east-1"
}

#Configuring backend for tfstate file
terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "global/iam/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_name) #toset - changing list (user_name) to set
  name = each.value
}
