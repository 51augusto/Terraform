<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git::ssh://git@github.com/51augusto/Terraform.git//aws/iac/modules/naming-convention | master |

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_parameter_group.redis_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| description | Descrição do cluster redis a ser criado. | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| name | Nome do cluster redis a ser criado. | `string` | n/a | yes |
| node\_type | Instância a ser usado no cluster. | `string` | n/a | yes |
| subnet\_group\_name | Nome do cache subnet group a ser usado pelo cluster. | `string` | n/a | yes |
| vpc\_id | ID da VPC | `string` | n/a | yes |
| apply\_immediately | Quando essa opção é habilitada para `true`, todas as mudanças no Elasticache ocorrem **imediatamente** . Caso fique desabilitada, as mudanças solicitadas ocorrerão na próxima janela de manutenção (Recomendado para ambiente de PRD). | `bool` | `false` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| inbound\_rules | Lista de regras de entrada para liberação de IPs. | <pre>list(object({<br/>    description = string,<br/>    cidr_blocks = list(string)<br/>  }))</pre> | `[]` | no |
| maintenance\_window | Janela de manutenção para implementação de atualizações, por exemplo. | `string` | `"sun:03:00-sun:04:00"` | no |
| number\_cache\_clusters | Número de clusters (primary e replicas) que serão criados. | `number` | `1` | no |
| parameters | Lista de parâmetros a serem configurados no parameter group. | <pre>list(object({<br/>    name  = string<br/>    value = any<br/>  }))</pre> | `null` | no |
| pg\_family | Família do grupo de parâmetros do elasticache. | `string` | `"redis6.x"` | no |
| port | Número da porta em que cada cache node vai aceitar conexões. | `number` | `6379` | no |
| redis\_engine\_version | Número da versão do redis que será utilizada no cluster. | `string` | `"6.x"` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| security\_group\_ids | Segurity group para ser usado no cluster. | `set(string)` | `null` | no |
| snapshot\_retention\_limit | Número de dias que o ElastiCache vai reter automaticamente os snapshots do cluster antes de deletá-las. | `number` | `0` | no |
| snapshot\_window | Janela para realização de snapshot do cluster. | `string` | `"02:00-03:00"` | no |

## Outputs

| Name | Description |
|------|-------------|
| redis | Instância Redis. |
| security\_group | Security Group da instância EC2. |
<!-- END_TF_DOCS -->