<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cicd_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ops_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vpc_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.xray_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da função. | `string` | n/a | yes |
| runtime | Tipo de runtime. | `string` | n/a | yes |
| architectures | Tipos de arquitetura de CPU. | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| create\_app\_policy | Indica se deve criar a política de acesso para aplicações. | `bool` | `false` | no |
| create\_cicd\_policy | Indica se deve criar a política de acesso para CI/CD. | `bool` | `false` | no |
| create\_ops\_policy | Indica se deve criar a política de acesso para ferramentas de Operações. | `bool` | `false` | no |
| dead\_letter\_config | Configuração de Dead Letter. | <pre>object({<br>    target_arn = string<br>  })</pre> | `null` | no |
| description | Descrição da função. | `string` | `null` | no |
| file\_system\_config | Configuração de EFS. | <pre>object({<br>    arn              = string<br>    local_mount_path = string<br>  })</pre> | `null` | no |
| image\_uri | URI da imagem caso `runtime="docker"`. | `string` | `null` | no |
| layers | ARNs de versões de Lambda Layers a serem atachadas à função. | `list(string)` | `[]` | no |
| logging\_retention | Tempo em dias para retenção de logs no CloudWatch. | `number` | `14` | no |
| policy\_arns | ARNs de políticas a serem anexadas à Role padrão da função. | `list(string)` | `[]` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| tracing\_config | Configuração de Tracing. | <pre>object({<br>    mode = string<br>  })</pre> | `null` | no |
| vpc\_config | Configuração de VPC. | <pre>object({<br>    vpc_id             = string<br>    subnet_ids         = list(string)<br>    create_default_sg  = bool<br>    security_group_ids = list(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_policy | Política de acesso para aplicações. |
| cicd\_policy | Política de acesso para CI/CD. |
| lambda\_function | Função Lambda. |
| ops\_policy | Política de acesso para ferramentas de Operações. |
| sg | Security Group da função Lambda. |
<!-- END_TF_DOCS -->