module "this_use1" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  environment    = var.environment
  region         = "us-east-1"
}

module "this_sae1" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  environment    = var.environment
  region         = "sa-east-1"
}
