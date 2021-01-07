provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "acloudguru/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

resource "aws_instance" {
    
}