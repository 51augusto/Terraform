module "this_use1" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=1.0.0"
  component_name = "internal"
  resource_id    = null
  vpc_id         = "main"
  environment    = "prd"
  region         = "us-east-1"
}

module "this_sae1" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=1.0.0"
  component_name = "internal"
  resource_id    = null
  vpc_id         = "main"
  environment    = "prd"
  region         = "sa-east-1"
}