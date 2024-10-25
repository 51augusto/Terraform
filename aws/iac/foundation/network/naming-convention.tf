module "this_use1" {
  for_each       = var.resources
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = each.value.component_name
  resource_id    = each.value.resource_id
  vpc_id         = "egress"
  environment    = each.value.environment
  region         = "us-east-1"
}


module "this_use1_v2" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  environment    = "network"
  region         = "us-east-1"
}

module "this_sae1" {
  for_each       = var.resources
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = each.value.component_name
  resource_id    = each.value.resource_id
  vpc_id         = "egress"
  environment    = each.value.environment
  region         = "sa-east-1"
}

module "this_sae1_v2" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "internal"
  environment    = "network"
  region         = "sa-east-1"
}