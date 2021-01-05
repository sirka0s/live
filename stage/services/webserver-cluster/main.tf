provider "aws" {
    region = "us-east-1"
}

module "webserver_cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name  = "webservers-stage"
    db_remote_state_bucket = "kaos-terraform-state"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro" #Don't you fucking touch it
    min_size = 2
    max_size = 3
}

