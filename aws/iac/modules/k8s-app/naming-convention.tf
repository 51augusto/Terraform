module "this" {
  source         = "git::ssh://git@github.com/51augusto/Terraform.git//aws/iac/modules/naming-convention?ref=master"
  component_name = var.component_name
  environment    = var.environment
  region         = var.region
}

