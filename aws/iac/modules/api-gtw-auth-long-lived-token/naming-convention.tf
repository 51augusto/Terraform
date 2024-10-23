module "this" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git?ref=main"
  component_name = var.component_name
  environment    = var.environment
  region         = var.region
}