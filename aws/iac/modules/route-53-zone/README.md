<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.ext](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.int](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_domain\_name | Nome do domínio da zona privada. Quando **private\_zone** for true, essa variável deve ser fornecida. | `string` | `"anbima.cloud"` | no |
| private\_sub\_domain\_name | Nome do sub-domínio da zona privada. Quando **private\_zone** for true, essa variável deve ser fornecida. | `string` | `""` | no |
| private\_zone | Determina se uma zona privada será criada. | `bool` | `false` | no |
| private\_zone\_vpc\_ids | ID da VPC da Zona Privada. | `map(any)` | `{}` | no |
| public\_domain\_name | Nome do domínio da zona pública. Quando **public\_zone** for true, essa variável deve ser fornecida. | `string` | `"anbima.com.br"` | no |
| public\_sub\_domain\_name | Nome do sub-domínio da zona pública. Quando **public\_zone** for true, essa variável deve ser fornecida. | `string` | `""` | no |
| public\_zone | Determina se uma zona pública será criada | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_53\_zone\_ext\_id | ID da zona pública. |
| route\_53\_zone\_ext\_name | Nome da zona pública. |
| route\_53\_zone\_int\_id | ID da zona privada. |
| route\_53\_zone\_int\_name | Nome da zona privada. |
<!-- END_TF_DOCS -->