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
| [aws_dynamodb_table.table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da tabela. | `string` | n/a | yes |
| attributes | Lista de atributos da tabela. | <pre>list(object({<br/>    name : string,<br/>    type : string<br/>  }))</pre> | `[]` | no |
| billing\_mode | Modo de cobrança da tabela: PAY\_PER\_REQUEST ou PROVISIONED. | `string` | `"PAY_PER_REQUEST"` | no |
| create\_app\_policy | Indica se deve criar a política de acesso para aplicações. | `bool` | `false` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| global\_indexes | Lista de índices locais. | <pre>list(object({<br/>    name : string,<br/>    read_capacity : number,<br/>    write_capacity : number,<br/>    hash_key : string,<br/>    range_key : string,<br/>    projection_type : string,<br/>    non_key_attributes : list(string)<br/>  }))</pre> | `[]` | no |
| hash\_key | Chave primária da tabela. | <pre>object({<br/>    name : string,<br/>    type : string<br/>  })</pre> | <pre>{<br/>  "name": "ID",<br/>  "type": "N"<br/>}</pre> | no |
| local\_indexes | Lista de índices locais. | <pre>list(object({<br/>    name : string,<br/>    range_key : string,<br/>    projection_type : string,<br/>    non_key_attributes : list(string)<br/>  }))</pre> | `[]` | no |
| range\_key | Chave para ordenação da tabela. | <pre>object({<br/>    name : string,<br/>    type : string<br/>  })</pre> | `null` | no |
| read\_capacity | Número de unidades de leitura da tabela. | `number` | `null` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| table\_class | Classe de armazenamento da tabela: STANDARD ou STANDARD\_INFREQUENT\_ACCESS. | `string` | `"STANDARD"` | no |
| ttl | Configuração de TTL da tabela. | <pre>object({<br/>    enabled : bool,<br/>    attribute : string<br/>  })</pre> | <pre>{<br/>  "attribute": "ttl",<br/>  "enabled": false<br/>}</pre> | no |
| write\_capacity | Número de unidades de escrita da tabela. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_policy | Política de acesso para aplicações. |
| table | Tabela do DynamoDB |
<!-- END_TF_DOCS -->