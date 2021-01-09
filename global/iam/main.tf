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

#Cloudwatch RO policy
data "aws_iam_policy_document" "cloudwatch_ro" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = [ "*" ]
  }
}

#Cloudwatch Full Access Policy
data "aws_iam_policy_document" "cloudwatch_full" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:*"
    ]
    resources = [ "*" ]
  }
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_name) #toset - changing list (user_name) to set
  name = each.value
}

#Define IAM policies
resource "aws_iam_policy" "cloudwatch_ro" {
  name = "cloudwatch-ro"
  policy = data.aws_iam_policy_document.cloudwatch_ro.json
}

resource "aws_iam_policy" "cloudwatch_full" {
  name = "cloudwatch-full"
  policy = data.aws_iam_policy_document.cloudwatch_full.json
}

#Create one of two based on bool value
resource "aws_iam_user_policy_attachment" "neo_cloudwatch" {
  count = var.give_neo_cloudwatch_full_access ? 1 : 0

  user = aws_iam_user[0].name
  policy_arn = aws.aws_iam_policy.cloudwatch_full.arn
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch" {
  count = var.give_neo_cloudwatch_full_access ? 0 : 1

  user = aws_iam_user[0].name
  policy_arn = aws.aws_iam_policy.cloudwatch_ro.arn
}