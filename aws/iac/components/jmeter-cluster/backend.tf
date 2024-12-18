terraform {
  backend "s3" {
    key            = "jmeter-shared/terraform.tfstate"
    bucket         = "s3-terraform-backend-shared-use1-tfstate"
    encrypt        = true
    dynamodb_table = "dynamo-terraform-backend-shared-use1-tfstate"
    region         = "us-east-1"
    profile        = "shared-services"

  }
}