provider "aws" {
    region = "us-east-1"
}

#Configuring backend for tfstate file
terraform {
  backend "s3" {
      bucket = "kaos-terraform-state"
      key = "prod/services/webserver-cluster/terraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "kaos-terraform-state-lock"
      encrypt = true
  }
}

module "webserver_cluster" {
    #source = "../../../../modules/services/webserver-cluster"
    source = "github.com/sirka0s/modules//services/webserver-cluster"

    cluster_name  = "webservers-prod"
    db_remote_state_bucket = "kaos-terraform-state"
    db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro" #Don't you fucking touch it
    min_size = 2
    max_size = 10

    enable_autoscaling = true
    enable_new_user_data = true

    custom_tagsy = {
      Owner = "kaos"
      DeployedBy = "terraform"
    }
}