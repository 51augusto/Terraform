module "sso_app" {
  source           = "git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/sso-app-permission-sets.git?ref=main"
  sso_applications = var.sso_applications
}