module "this" {
  source         = "git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = "internal"
  environment    = "prd"
  region         = "us-east-1"
}
