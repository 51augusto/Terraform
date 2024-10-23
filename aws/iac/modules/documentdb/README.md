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
| [aws_cloudwatch_log_group.log_group_audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.log_group_profiler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_docdb_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.cluster_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.cluster_pg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.default_egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| db\_subnet\_group\_name | Nome do Subnet Group do banco de dados. | `string` | n/a | yes |
| engine\_version | Versao do banco de dados. | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| master\_password | Senha do banco de dados. | `string` | n/a | yes |
| name | Nome do RDS. | `string` | n/a | yes |
| vpc\_id | ID da VPC do banco de dados. | `string` | n/a | yes |
| availability\_time | Período de disponibilidade do serviço: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`. | `string` | `"24/7"` | no |
| backup\_retention\_period | Período de retenção do backup via snapshot. | `number` | `7` | no |
| cluster\_instances | Quantidade de servidores no cluster. | `number` | `1` | no |
| db\_cluster\_parameter\_group\_name | Nome do Cluster Parameter Group a ser associado ao cluster. Se indefinido, cria um padrão com a familia definida em `parameter_group_family`. | `string` | `""` | no |
| deletion\_protection | Se verdadeiro, necessita desabilitar no console a proteção contra exclusão acidental. | `string` | `false` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| inbound\_rules | Lista de regras de entrada para liberação de IPs. | <pre>list(object({<br>    description = string,<br>    cidr_blocks = list(string)<br>  }))</pre> | `[]` | no |
| instance\_class | Tamanho da instancia de banco de dados. | `string` | `"db.t4g.medium"` | no |
| logging\_retention | Tempo em dias para retenção de logs no CloudWatch. | `number` | `14` | no |
| master\_username | Nome de usuario master do banco de dados. | `string` | `"dbadmin"` | no |
| parameter\_group\_family | Família do grupo de parâmetros do banco de dados. | `string` | `""` | no |
| preferred\_backup\_window | Janela de backup via snapshot. | `string` | `"07:00-09:00"` | no |
| preferred\_maintenance\_window | Janela de manutenção para implementação de atualizações, por exemplo. | `string` | `"sun:04:00-sun:04:30"` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| skip\_final\_snapshot | Se verdadeiro, não necessita de snapshot final para destruir o banco de dados. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster | Cluster DocumentDB |
<!-- END_TF_DOCS -->