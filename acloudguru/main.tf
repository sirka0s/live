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

/* works, but name filter is a mystery kekw

data "aws_ami" "amazon" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["Amazon*AMI*SSD*"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter { 
        name = "architecture"
        values = ["x86_64"]
    }
}
*/

resource "aws_instance" "ami_test" {
    ami = "ami-0be2609ba883822ec"
    instance_type = "t2.micro"
    monitoring = true # CloudWatch Detailed Monitoring (not free tier!)
    key_name = "key_pair_kaos_aws"

    tags = {
        Name = "CloudWatchTest"
        DeployedBy = "terraform"
    }
}

output "instance_id" {
    value = aws_instance.ami_test.id
}
