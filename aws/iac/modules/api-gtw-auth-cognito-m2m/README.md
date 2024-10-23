Exemplo de uso:

```
module "api_gateway_auth" {
  source                   = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/components/api-gateway/modules/cognito-m2m-auth.git?ref=main"
  component_name           = var.component_name
  environment              = var.environment
  region                   = var.region
  name                     = "auth"
  api_id                   = module.api_gateway.api.id
  endpoint_domain          = api-auth.cer.anbima.com.br
  endpoint_certificate_arn = "certificate_arn"
  resources = {
    "RECURSO-1" = {
      "ESCOPO"       = "Descrição do Escopo"
      "OUTRO_ESCOPO" = "Descrição do Outro Escopo"
    }
    "RECURSO-2" = {
      "ESCOPO" = "Descrição do Escopo"
    }
  }
  clients = {
    "app-client-1" = ["RECURSO-1/ESCOPO", "RECURSO-1/OUTRO_ESCOPO"]
    "app-client-2" = ["RECURSO-2/ESCOPO"]
  }
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_authorizer.authorizer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_authorizer) | resource |
| [aws_cognito_resource_server.default_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server) | resource |
| [aws_cognito_resource_server.resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server) | resource |
| [aws_cognito_user_pool.user_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.user_pool_client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.user_pool_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_id | Ientificador da API que será associada ao Authorizer. | `string` | n/a | yes |
| clients | Clientes da API. | `map(any)` | n/a | yes |
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| endpoint\_certificate\_arn | ARN do certificado para o endpoint de autenticação. | `string` | n/a | yes |
| endpoint\_domain | Domínio para o endpoint de autenticação. | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome do Authorizer. | `string` | n/a | yes |
| deletion\_protection | Ativa a proteção contra deleção do Cognito User Pool. | `bool` | `true` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |
| resources | Recursos da API. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| authorizer | Authorizer |
<!-- END_TF_DOCS -->