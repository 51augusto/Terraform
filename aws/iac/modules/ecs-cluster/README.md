<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| ecs | terraform-aws-modules/ecs/aws | 5.2.0 |
| service | ./fargate-service | n/a |
| this | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cicd_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| create\_cicd\_policy | Indica se deve criar a política de acesso para CI/CD. | `bool` | `false` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| secret\_arns | ARNs dos secrets utilizados pelos serviços do cluster, caso não sejam especificadas na definição do próprio serviço. | `list(string)` | `[]` | no |
| services | Serviços a serem instalados no cluster. | `map(any)` | `{}` | no |
| spot | Indica se serviços devem usar Fargate Spot, caso não sejam especificado na definição do próprio serviço. | `bool` | `true` | no |
| subnet\_ids | IDs das subnets a serem utilizadas pelos serviços do cluster, caso não sejam especificadas na definição do próprio serviço. | `list(string)` | `[]` | no |
| vpc\_id | ID da VPC onde os serviços serão alocados, caso não seja especificada na definição do próprio serviço. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cicd\_policy | Política de acesso para CI/CD. |
| ecs\_cluster\_arn | ARN do cluster ECS criado. |
<!-- END_TF_DOCS -->