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
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cicd_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.lambda_edge_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da função. | `string` | n/a | yes |
| architectures | Tipos de arquitetura de CPU. | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| create\_cicd\_policy | Indica se deve criar a política de acesso para CI/CD. | `bool` | `false` | no |
| description | Descrição da função. | `string` | `null` | no |
| filename | Path para o pacote com o código da função. | `string` | `null` | no |
| handler | Handler da função. | `string` | `"index.handler"` | no |
| layers | ARNs de versões de Lambda Layers a serem atachadas à função. | `list(string)` | `[]` | no |
| logging\_retention | Tempo em dias para retenção de logs no CloudWatch. | `number` | `14` | no |
| policy\_arns | ARNs de políticas a serem anexadas à Role padrão da função. | `list(string)` | `[]` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| runtime | Tipo de runtime. | `string` | `"nodejs14.x"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cicd\_policy | Política de acesso para CI/CD. |
| lambda\_edge\_function | Função Lambda@Edge. |
<!-- END_TF_DOCS -->