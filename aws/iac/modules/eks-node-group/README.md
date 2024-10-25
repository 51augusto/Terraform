<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |
| random | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| eks\_node\_group | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/eks-cluster-hashicorp.git//modules/node_groups | main |
| this | git::ssh://git@github.com/51augusto/Terraform.git//aws/iac/modules/naming-convention | master |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group_tag.asg_tag_label](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag) | resource |
| [aws_autoscaling_group_tag.asg_tag_taint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| eks\_cluster\_ca\_cert | Certificado base64 do cluster EKS | `string` | n/a | yes |
| eks\_cluster\_endpoint | Endpoint do cluster EKS | `string` | n/a | yes |
| eks\_cluster\_name | Nome do cluster EKS | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| k8s\_version | Versão do Kubernetes do node group | `string` | n/a | yes |
| node\_group\_suffix\_name | Sufixo para o nome do Node Group. Será o valor do taint node/reserved-for. Na AWS o nome ficará nodes-$node\_group\_suffix\_name | `string` | n/a | yes |
| private\_subnets\_ids | IDs das subnets privadas para workers do node group. | `list(string)` | n/a | yes |
| region | AWS Region | `string` | n/a | yes |
| worker\_iam\_role\_arn | ARN da role que será utilizada pelos workers do node group. | `string` | n/a | yes |
| worker\_security\_group\_id | ID do security group dos workers. Utilizar o mesmo dos nodes groups system. Usar output do módulo de cluster EKS. | `string` | n/a | yes |
| capacity\_type | Modelo de preço das instâncias. Valores permitidos: `ON_DEMAND` e `SPOT` | `string` | `"ON_DEMAND"` | no |
| cpu\_credits | Módo de créditos de CPU para instâncias T: `standard` ou `unlimited`. | `string` | `"standard"` | no |
| desired\_capacity | Capacidade desejada para o Auto Scaling Group. | `number` | `1` | no |
| disk\_size | Tamanho do disco EBS das EC2 do Node Group | `number` | `30` | no |
| enable\_monitoring | Determina se o monitoramento detalhado será habilitado para as EC2 do node group. | `bool` | `false` | no |
| instance\_types | Tipos de instâncias EC2 do node group. | `list(string)` | <pre>[<br/>  "t3.large"<br/>]</pre> | no |
| launch\_template\_version | Versão do launch tamplate. Por padrão está setando a versão mais recente. | `string` | `"$Latest"` | no |
| max\_capacity | Capacidade máxima para o Auto Scaling Group. | `number` | `3` | no |
| max\_unavailable | Quantidade máxima de nós que podem ficar indisponíveis durante um update. | `number` | `1` | no |
| min\_capacity | Capacidade mínima para o Auto Scaling Group. | `number` | `1` | no |
| node\_group\_force\_update | Ao alterar essa variável, o node group será destruído e recriado. | `number` | `0` | no |
| tags | Tags adicionais para todos os recursos do módulo. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->