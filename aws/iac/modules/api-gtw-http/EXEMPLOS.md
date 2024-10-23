# Exemplos de uso do módulo

```terraform
module "vpc_link" {
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/components/api-gateway/modules/vpc-link-v2.git?ref=main"
  component_name = var.component_name
  environment    = var.environment
  region         = var.region
  name           = "api"
  vpc_id         = data.terraform_remote_state.main.outputs.vpc_use1_id
  subnets_ids    = data.terraform_remote_state.main.outputs.vpc_use1_private_subnets_ids
}

module "api" {
  source          = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/api-gtw-http.git?ref=develop"
  component_name  = var.component_name
  environment     = var.environment
  region          = var.region
  name            = "api"
  domain_name     = "api.cer.anbima.com.br"
  certificate_arn = data.terraform_remote_state.main.outputs.acm_use1_certificate_public.arn
}

module default_endpoint {
  source     = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/api-gtw-http.git//public-http-proxy?ref=develop"
  api_id     = module.api.api.id
  default    = true
  target_uri = "https://external.prd.anbima.com.br/teste/"
}

module public_endpoint {
  source     = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/api-gtw-http.git//public-http-proxy?ref=develop"
  api_id     = module.api.api.id
  path       = "/alou/{proxy+}"
  target_uri = "https://external.prd.anbima.com.br/teste3/{proxy}"
}

module private_endpoint {
  source                 = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/api-gtw-http.git//private-http-proxy?ref=develop"
  api_id                 = module.api.api.id
  vpc_link_id            = module.vpc_link.vpc_link.id
  path                   = "/ebooks/{proxy+}"
  target_lb_listener_arn = "arn:aws:elasticloadbalancing:us-east-1:849598278174:listener/app/alb-eks-shared-cer-use1-internal/c50edaa8244a1baf/5a63afb0009f0de3"
  target_tls_domain      = "cer.anbima.cloud"
  target_host            = "ebooks-api.cer.anbima.cloud"
}

module lambda_endpoint {
  source            = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/api-gtw-http.git//lambda-proxy?ref=develop"
  api_id            = module.api.api.id
  api_execution_arn = module.api.api.execution_arn
  path              = "/lambda/{proxy+}"
  lambda_arn        = module.lambda_teste.lambda_function.arn
  lambda_invoke_arn = module.lambda_teste.lambda_function.invoke_arn
}
```