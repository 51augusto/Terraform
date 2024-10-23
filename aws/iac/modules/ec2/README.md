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
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_exporter_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rdp_sg_anbima_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rdp_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.default_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | ID da AMI da instância. | `string` | n/a | yes |
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da instância. | `string` | n/a | yes |
| subnet | ID da subnet da instância. | `string` | n/a | yes |
| tags | Tags obrigatórias. | <pre>object({<br>    Role : string<br>    Version : string<br>  })</pre> | n/a | yes |
| allow\_rdp | Habilita a criação de regras de acesso ao RDP | `bool` | `false` | no |
| availability\_time | Período de disponibilidade da instância: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`, `poweroff`. | `string` | `"24/7"` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| ebs\_optimized | Habilita otimização de EBS. | `bool` | `true` | no |
| enable\_metadata\_tags | Habilita acesso às tags no metadata da instância. | `bool` | `true` | no |
| extra\_tags | Tags extras livres. | `map(any)` | `{}` | no |
| hostname | Valor do hostname para máquinas Windows, ignorado para máquinas Linux. Popula a Tag `Hostname` da instância, que é utilizada pós inicialização, para definição do hostname localmente e na OU do Active Directory. | `string` | `null` | no |
| instance\_type | Tipo da instância. | `string` | `"t3.micro"` | no |
| monitoring | Habilita monitoração detalhada. | `bool` | `false` | no |
| os | Sistema operacional. Valores permitidos: `linux` e `windows`. Utilizado para popular a Tag `OS` da instância | `string` | `"linux"` | no |
| policy\_arns | ARNs de políticas a serem anexadas à Role padrão da instância. Ignorado se uma role for definida. | `list(string)` | `[]` | no |
| private\_ip | Configura um IP privado específico para a instância | `string` | `null` | no |
| prometheus\_exporter | Habilita a instalação do Prometheus Exporter | `bool` | `true` | no |
| public\_ip | Habilita IP público para a instância | `bool` | `false` | no |
| rdp\_sg\_anbima\_pl | Prefix lists a serem adicionados na regra de RDP | `list(any)` | `null` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| role | Nome da Role a ser associada à instância. Se indefinido, uma nova será criada. | `string` | `null` | no |
| root\_ebs | Especificação do EBS raiz da instãncia. | <pre>object({<br>    size : string,<br>    type : string,<br>    encrypted : bool,<br>    delete_on_termination : bool<br>  })</pre> | <pre>{<br>  "delete_on_termination": true,<br>  "encrypted": true,<br>  "size": "40",<br>  "type": "gp3"<br>}</pre> | no |
| security\_group\_ids | Identificadores dos Security Groups a serem associados à instância. Se indefinido, um novo será criado. | `list(string)` | `null` | no |
| source\_dest\_check | Controla se o tráfego é roteado para as instâncias quando o endereço de destino não encontra a instância. Usado para NAT, VPNs ou Firewalls. | `bool` | `true` | no |
| termination\_protection | Habilita proteção contra termination da instância. | `bool` | `false` | no |
| user\_data | User Data da instância. Se indefinido utiliza o padrão de cada OS. | `string` | `null` | no |
| user\_data\_append | Conteúdo extra a ser adicionado ao fim do User Data padrão da instância. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance | Instância EC2. |
| role | Role da instância EC2. |
| security\_group | Security Group da instância EC2. |
<!-- END_TF_DOCS -->