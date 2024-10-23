data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-shared-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-shared-use1-tfstate"
    region         = "us-east-1"
    profile        = "shared-services"
  }
}