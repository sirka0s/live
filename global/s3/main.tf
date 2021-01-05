provider "aws" {
  region = "us-east-1"
}

#Configuring backend for tfstate file
terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "global/s3/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

#Configuring S3 bucket for backend
resource "aws_s3_bucket" "terraform_state" {
    bucket = "kaos-terraform-state"

    lifecycle {
      prevent_destroy = true
    }

    versioning {
      enabled = true
    }

    server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
    }   
}

#Configure DynamoDB table for lock states
resource "aws_dynamodb_table" "name" {
  name = "kaos-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}