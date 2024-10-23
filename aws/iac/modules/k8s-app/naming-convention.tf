module "this" {
  source         = "git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = var.app
  environment    = var.environment
  region         = var.region
}
