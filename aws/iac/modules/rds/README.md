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
| [aws_cloudwatch_log_group.rds_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_option_group.mysql_option_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_option_group.sqlserver_option_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_parameter_group.db_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.s3_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.databricks_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| db\_subnet\_group\_name | ID do Subnet Group que será utilizado pela instância | `string` | n/a | yes |
| engine\_version | Versão da engine do banco | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| instance\_class | Tipo de Instancia. | `string` | n/a | yes |
| name | Nome da base a ser criada. | `string` | n/a | yes |
| password | Senha do Root da Base | `string` | n/a | yes |
| type | Tipo da base de dados: `mysql`, `postgresql`, `mssql-ex`, `mssql-se`, `mssql-web` | `string` | n/a | yes |
| username | Username do Root da Base. | `string` | n/a | yes |
| vpc\_id | ID da VPC | `string` | n/a | yes |
| allocated\_storage | Alocação de storage para a instância do banco | `number` | `20` | no |
| apply\_immediately | Quando essa opção é habilitada para `true`, todas as mudanças no RDS ocorrem **imediatamente** . Caso fique desabilitada, as mudanças solicitadas ocorrerão na próxima janela de manutenção (Recomendado para ambiente de PRD). | `bool` | `false` | no |
| availability\_time | Período de disponibilidade do serviço: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`. | `string` | `"24/7"` | no |
| backup\_retention\_period | Período de retenção do backup via snapshot. | `number` | `7` | no |
| backup\_window | Janela de backup via snapshot. | `string` | `"07:00-09:00"` | no |
| copy\_tags\_to\_snapshot | Se copiará as tags para os snapshots ou não. | `bool` | `true` | no |
| db\_options | Lista de parâmetros a serem configurados no parameter group. | <pre>map(object({<br>    port = number<br>    option_settings = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | `{}` | no |
| db\_parameters | Lista de parâmetros a serem configurados no parameter group. | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| deletion\_protection | Se verdadeiro, necessita desabilitar no console a proteção contra exclusão acidental. | `string` | `false` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| inbound\_rules | Lista de regras de entrada para liberação de IPs. | <pre>list(object({<br>    description = string,<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| iops | Quantidade de IOPS provisionados. Valores aceitos: SQLServer (3000–16000 IOPS) - Demais (12000–64000 IOPS) | `number` | `null` | no |
| logging\_retention | Tempo em dias para retenção de logs no CloudWatch. | `number` | `14` | no |
| maintenance\_window | Janela de manutenção para implementação de atualizações, por exemplo. | `string` | `"sun:04:00-sun:04:30"` | no |
| max\_allocated\_storage | Tamanho máximo de alocação de storage para a instância do banco | `number` | `null` | no |
| monitoring\_interval | Intervalo do recurso enhanced monitoring. | `number` | `30` | no |
| multi\_az | Executar em MultiAZ. | `bool` | `false` | no |
| parameter\_group\_family | Família do grupo de parâmetros do banco de dados. | `string` | `""` | no |
| performance\_insights\_enabled | Indica se performance insights será ativado ou não. Atenção para o suporte desse recurso no MySQL: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights.Overview.Engines.html | `bool` | `true` | no |
| performance\_insights\_retention\_period | Período de retenção dos dados do Performance Insights. | `number` | `7` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| s3\_policy\_arn | Policy que será atribuída à role do RDS SQL Server. Obrigatório caso seja criado um RDS SQL Server. | `string` | `null` | no |
| s3\_role | Role com acesso ao Bucket S3 que será usado para backup/restore instâncias SQL Server | `string` | `null` | no |
| security\_group\_ids | Segurity group para Base. | `set(string)` | `null` | no |
| skip\_final\_snapshot | Se verdadeiro, não necessita de snapshot final para destruir o banco de dados. | `bool` | `false` | no |
| storage\_throughput | Quantidade de MiB provisionados. Valores aceitos: SQLServer (125–1000 MiB/s) - Demais (500–4000 MiB/s) | `number` | `null` | no |
| storage\_type | Tipo de Disco. | `string` | `"gp2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_name | Nome do schema da instância do RDS. |
| hostname | Hostname da instância do RDS. |
| port | Porta da instância do RDS. |
<!-- END_TF_DOCS -->