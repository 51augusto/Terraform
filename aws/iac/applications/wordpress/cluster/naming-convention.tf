module "this" {
  source         = "git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git?ref=master"
  component_name = "wordpress"
  environment    = "prd"
  region         = "us-east-1"
}
