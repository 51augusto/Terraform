data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-shared-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-shared-use1-tfstate"
    region         = "us-east-1"
    profile        = "shared-services"
  }
}

data "aws_subnet" "subnet" {
  id = var.subnet
}

data "aws_default_tags" "default_tags" {}

data "aws_caller_identity" "current" {}