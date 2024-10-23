module "this_use1" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = "internal"
  environment    = var.environment
  region         = "us-east-1"
}

module "this_sae1" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = "internal"
  environment    = var.environment
  region         = "sa-east-1"
}
