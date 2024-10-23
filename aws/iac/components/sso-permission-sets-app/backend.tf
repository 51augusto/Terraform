terraform {
  backend "s3" {
    key            = "sso-permission-sets-app/terraform.tfstate"
    bucket         = "s3-terraform-backend-management-use1-tfstate"
    encrypt        = true
    dynamodb_table = "dynamo-terraform-backend-management-use1-tfstate"
    region         = "us-east-1"
    profile        = "management"
  }
}