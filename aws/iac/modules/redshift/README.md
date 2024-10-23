<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.26.0 |
| terraform | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_redshift_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster) | resource |
| [aws_redshift_parameter_group.pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_parameter_group) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.databricks_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_subnet\_group\_name | Nome do Subnet Group do cluster. | `string` | n/a | yes |
| cluster\_type | Tipo do cluster | `string` | n/a | yes |
| cluster\_version | Versão do cluster | `string` | n/a | yes |
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| master\_password | Senha do banco de dados. | `string` | n/a | yes |
| name | Nome do Cluster Redshift. | `string` | n/a | yes |
| vpc\_id | ID da VPC do cluster. | `string` | n/a | yes |
| allow\_version\_upgrade | Permitir upgrade automático de versão Major do cluster. | `bool` | `false` | no |
| automated\_snapshot\_retention\_period | Período de retenção do backup automático via snapshot. | `number` | `7` | no |
| availability\_zone | Zona de disponibilidade para provisionamento do cluster. | `string` | `null` | no |
| database\_name | Nome da primeira database criada quando o cluster é criado | `string` | `"dev"` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| enhanced\_vpc\_routing | Ativa recursos de roteamento aprimorado da VPC. | `bool` | `false` | no |
| iam\_roles | Roles a serem associadas ao cluster. | `list(string)` | `[]` | no |
| inbound\_rules | Lista de regras de entrada para liberação de IPs. | <pre>list(object({<br>    description = string,<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| logging | Configuração de logging do cluster. | <pre>object({<br>    enable        = bool<br>    bucket_name   = string<br>    s3_key_prefix = string<br>  })</pre> | <pre>{<br>  "bucket_name": "",<br>  "enable": false,<br>  "s3_key_prefix": ""<br>}</pre> | no |
| master\_username | Nome de usuario master do banco de dados. | `string` | `"dbadmin"` | no |
| node\_type | Tipo do nó que compõe o cluster | `string` | `"dc2.large"` | no |
| number\_of\_nodes | Número de nós que compõe o cluster | `number` | `1` | no |
| parameter\_group\_family | Família do grupo de parâmetros do cluster. | `string` | `""` | no |
| parameter\_group\_name | Nome do Cluster Parameter Group a ser associado ao cluster. Se indefinido, cria um padrão com a familia definida em `parameter_group_family`. | `string` | `""` | no |
| preferred\_maintenance\_window | Janela de manutenção para implementação de atualizações, por exemplo. | `string` | `"sun:04:00-sun:04:30"` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| skip\_final\_snapshot | Se verdadeiro, não necessita de snapshot final para destruir o banco de dados. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | Cluster Redshift |
<!-- END_TF_DOCS -->