

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
| [aws_efs_access_point.access_points](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.file_system](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cidr_blocks_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.shared_account_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| subnets\_ids | Identificadores da subnets. | `list(string)` | n/a | yes |
| vpc\_id | Identificador da VPC. | `string` | n/a | yes |
| access\_points | Configurações dos Access Points do EFS. As chaves do mapa são os nomes dos APs. | <pre>map(object({<br>    path        = string<br>    uid         = number<br>    gid         = number<br>    permissions = string<br>  }))</pre> | `{}` | no |
| dr\_backup | Habilita o DR Backup. | `bool` | `false` | no |
| encrypted | Criptografar o sistema de arquivos. | `bool` | `true` | no |
| ingress\_cidr\_blocks | Lista de blocos CIDR que devem ter acesso ao EFS. | `list(string)` | `null` | no |
| performance\_mode | Modo de performance do sistema de arquivos: `generalPurpose` ou `maxIO`. | `string` | `"generalPurpose"` | no |
| provisioned\_throughput | Taxa de transferência em MiB/s a ser utilizada caso `throughput_mode = provisioned`. | `number` | `null` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |
| throughput\_mode | Modo de taxa de transferência para o sistema de arquivos: `bursting` ou `provisioned`. | `string` | `"bursting"` | no |
| transition\_to\_ia | Tempo para transição de arquivos para a classe de armazenamento IA: `AFTER_7_DAYS`, `AFTER_14_DAYS`, `AFTER_30_DAYS`, `AFTER_60_DAYS` ou `AFTER_90_DAYS`. | `string` | `null` | no |
| transition\_to\_primary\_storage\_class | Política para transição de um arquivo do armazenamento IA para o armazenamento primário: `AFTER_1_ACCESS`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_points | Access Points do EFS |
| file\_system | File system do EFS. |
| security\_group | Security Group do EFS |
<!-- END_TF_DOCS -->