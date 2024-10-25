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
| [aws_ecr_lifecycle_policy.ecr_repo_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy.pull_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome do repositório ECR. | `string` | n/a | yes |
| create\_pull\_policy | Indica se deve criar a política de pull de imagens. | `bool` | `false` | no |
| max\_release\_tags | Numero máximo de tags de release a serem mantidas. | `number` | `20` | no |
| read\_principal | Principal da política de leitura no repositório ECR. Padrão: contas de Workload. | `map(any)` | <pre>{<br/>  "AWS": [<br/>    "arn:aws:iam::880974337725:root",<br/>    "arn:aws:iam::849598278174:root",<br/>    "arn:aws:iam::241290613667:root",<br/>    "arn:aws:iam::899836677866:root"<br/>  ]<br/>}</pre> | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| release\_tag\_prefixes | Prefixos das tags de release. | `list(string)` | <pre>[<br/>  "v"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| pull\_policy | Política de pull de imagens do repositório. |
| repository | Repositório ECR |
<!-- END_TF_DOCS -->