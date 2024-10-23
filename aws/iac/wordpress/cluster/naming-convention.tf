module "this" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = "wordpress"
  environment    = "prd"
  region         = "us-east-1"
}