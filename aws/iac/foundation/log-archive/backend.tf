terraform {
  backend "s3" {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-logs-use1-tfstate"
    encrypt        = true
    dynamodb_table = "dynamo-terraform-backend-logs-use1-tfstate"
    region         = "us-east-1"
    profile        = "log-archive"
  }
}