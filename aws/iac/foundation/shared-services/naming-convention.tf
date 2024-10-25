module "this_use1" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  resource_id    = null
  vpc_id         = "main"
  environment    = "shared"
  region         = "us-east-1"
}

module "this_sae1" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  resource_id    = null
  vpc_id         = "main"
  environment    = "shared"
  region         = "sa-east-1"
}
