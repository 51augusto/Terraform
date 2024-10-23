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
| [aws_apigatewayv2_api.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_api_mapping.api_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_domain_name.domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_arn | ARN do certificado do Domínio da API | `string` | n/a | yes |
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| domain\_name | Nome do Domínio da API | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da API | `string` | n/a | yes |
| cors\_configuration | Configurações de CORS da API | <pre>object({<br>    allow_credentials = bool<br>    allow_headers     = list(string)<br>    allow_methods     = list(string)<br>    allow_origins     = list(string)<br>    expose_headers    = list(string)<br>    max_age           = number<br>  })</pre> | `null` | no |
| description | Descrição da API | `string` | `null` | no |
| disable\_execute\_api\_endpoint | Desabilita chamadas à API através do endpoint padrão | `bool` | `true` | no |
| enable\_access\_log | Habilita o registro de Access Logs | `bool` | `false` | no |
| logging\_format | Formato dos Access Logs, ref.: https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-logging.html | `string` | `"$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId"` | no |
| logging\_retention | Tempo em dias para retenção de Access Logs no CloudWatch | `number` | `14` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| api | API |
<!-- END_TF_DOCS -->