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