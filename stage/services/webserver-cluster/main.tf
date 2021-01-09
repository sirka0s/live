provider "aws" {
    region = "us-east-1"
}

#Configuring backend for tfstate file
terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "stage/services/webservers-cluster/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

module "webserver_cluster" {
    source = "github.com/sirka0s/modules//services/webserver-cluster?ref=v0.0.6"

    cluster_name  = "webservers-stage"
    db_remote_state_bucket = "kaos-terraform-state"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro" #Don't you fucking touch it
    min_size = 2
    max_size = 3
    enable_autoscaling = false
    enable_new_user_data = false
}

