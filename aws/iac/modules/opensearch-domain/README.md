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
| [aws_cloudwatch_log_group.log_group_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.log_group_es_application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.log_group_index_slow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.log_group_search_slow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.log_resource_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_kms_alias.kms_key_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_opensearch_domain.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_opensearch_domain_saml_options.saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_saml_options) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| endpoint\_certificate\_arn | Certificado para o endpoint de acesso ao cluster. | `string` | n/a | yes |
| endpoint\_domain | Domíno do endpoint de acesso ao cluster. | `string` | n/a | yes |
| engine\_version | Versão da engine do OpenSearch. | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| instance\_count | Quantidade de nós do cluster. | `string` | n/a | yes |
| instance\_type | Tipo de instância dos nós do cluster. | `string` | n/a | yes |
| master\_password | Senha do usuário master da Base. | `string` | n/a | yes |
| master\_username | Username do usuário master da Base. | `string` | n/a | yes |
| name | Nome do cluster OpenSearch a ser criado. | `string` | n/a | yes |
| subnet\_ids | Subnets para o cluster. | `set(string)` | n/a | yes |
| vpc\_id | ID da VPC. | `string` | n/a | yes |
| advanced\_options | Opções de configuração avançada do OpenSearch. | `map(string)` | `{}` | no |
| dedicated\_masters | Configuração para nós mestres dedicados. Ignorado se nulo. | <pre>object({<br/>    count = number<br/>    type  = string<br/>  })</pre> | `null` | no |
| dr\_backup | Habilita o DR Backup. | `bool` | `false` | no |
| enable\_auto\_tune | Indica se deve habilitar o Auto Tune no cluster. | `bool` | `true` | no |
| endpoint\_tls\_policy | Política de TLS do endpoint de acesso ao cluster. | `string` | `"Policy-Min-TLS-1-2-2019-07"` | no |
| inbound\_rules | Lista de regras de entrada para liberação de IPs. | <pre>list(object({<br/>    description = string<br/>    cidr_blocks = list(string)<br/>  }))</pre> | `[]` | no |
| logging\_retention | Tempo em dias para retenção de logs no CloudWatch. | `number` | `14` | no |
| multi\_az | Executar cluster em MultiAZ. | `bool` | `false` | no |
| off\_peak\_window\_start | Início da janela de 10 horas de baixo consumo do cluster em UTC. Padrão: `22:30-08:30` Brasília. | <pre>object({<br/>    hours   = string<br/>    minutes = string<br/>  })</pre> | <pre>{<br/>  "hours": "01",<br/>  "minutes": "30"<br/>}</pre> | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| saml\_config | Configurações de SAML | <pre>object({<br/>    entity_id               = string<br/>    metadata_content        = string<br/>    master_backend_role     = string<br/>    master_username         = string<br/>    roles_key               = string<br/>    session_timeout_minutes = number<br/>    subject_key             = string<br/><br/>  })</pre> | `null` | no |
| security\_group\_ids | Segurity group para o cluster. | `set(string)` | `null` | no |
| storage\_iops | Quantidade de IOPS provisionados para os discos dos nós do cluster. Valores aceitos: 3000–16000 IOPS. | `number` | `3000` | no |
| storage\_size | Alocação de storage para cada nó do cluster. | `number` | `20` | no |
| storage\_throughput | Quantidade de MiB/s provisionados para os discos dos nós do cluster. Valores aceitos: 125–593 MiB/s. | `number` | `125` | no |
| storage\_type | Tipo de disco dos nós do cluster. | `string` | `"gp3"` | no |
| use\_default\_kms | Indica se deve utilizar a chave KMS padrão ou criar uma dedicada. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->