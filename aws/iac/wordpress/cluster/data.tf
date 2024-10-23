data "terraform_remote_state" "main" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-prd-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-prd-use1-tfstate"
    region         = "us-east-1"
    profile        = "workload-prd"
  }
}

data "terraform_remote_state" "waf" {
  backend = "s3"
  config = {
    key            = "waf/terraform.tfstate"
    bucket         = "s3-terraform-backend-prd-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-prd-use1-tfstate"
    region         = "us-east-1"
    profile        = "workload-prd"
  }
}

data "terraform_remote_state" "wordpress" {
  backend = "s3"
  config = {
    key            = "wordpress/terraform.tfstate"
    bucket         = "s3-terraform-backend-prd-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-prd-use1-tfstate"
    region         = "us-east-1"
    profile        = "workload-prd"
  }
}

data "terraform_remote_state" "monitoring" {
  backend = "s3"
  config = {
    key            = "monitoring/terraform.tfstate"
    bucket         = "s3-terraform-backend-prd-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-prd-use1-tfstate"
    region         = "us-east-1"
    profile        = "workload-prd"
  }
}

data "aws_secretsmanager_secret_version" "db_root_credentials" {
  secret_id = "secret-wordpress-prd-use1-mysql-root-credentials"
}

data "aws_subnet" "private_subnets" {
  count = length(data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids)
  id    = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids[count.index]
}
