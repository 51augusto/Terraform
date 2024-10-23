data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
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

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-network-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-network-use1-tfstate"
    region         = "us-east-1"
    profile        = "network"
  }
}