<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |
| kubernetes | >= 2.0.0 |
| random | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| eks | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/eks-cluster-hashicorp.git | main |
| this | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.worker_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group_rule.ssh_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_string.system_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.worker_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| k8s\_version | Versão do Kubernetes no cluster EKS. | `string` | n/a | yes |
| ng\_system\_k8s\_version | Versão do Kubernetes do node group system | `string` | n/a | yes |
| private\_subnets\_ids | IDs das subnets privadas para o cluster e workers Kubernetes. | `list(string)` | n/a | yes |
| system\_node\_group\_config | Configurações do node group system | `any` | n/a | yes |
| vpc\_id | ID da VPC. | `string` | n/a | yes |
| accounts\_aws\_auth | Lista de contas AWS para interagirem com o Kubernetes. | `list(string)` | `[]` | no |
| cluster\_enabled\_log\_types | Lista com os tipos de logs que serão habilitados para o cluster EKS. Valores válidos: `api`, `audit`, `authenticator`, `controllerManager`, `scheduler` | `list(string)` | `[]` | no |
| cluster\_log\_retention\_in\_days | Retenção dos logs do Cluster EKS em dias ( `api`, `audit`, `authenticator`, `controllerManager`, `scheduler` ) . | `number` | `30` | no |
| max\_unavailable | Quantidade máxima de nós que podem ficar indisponíveis durante um update. | `number` | `1` | no |
| node\_groups\_disk\_size | Tamanho dos discos dos node groups. | `number` | `30` | no |
| node\_groups\_enable\_monitoring | Determina se o monitoramento para os node groups será habilitado ou não. | `bool` | `false` | no |
| region | AWS Region | `string` | `"us-east-1"` | no |
| roles\_aws\_auth | Roles do IAM para interagirem com o Kubernetes. Obs: permite a visualização na console AWS dependendo do grupo escolhido. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| system\_node\_group\_force\_update | Ao alterar essa variável, o node group de sistema será destruído e recriado. | `number` | `0` | no |
| tags | Tags adicionais para todos os recursos do módulo. | `map(string)` | `{}` | no |
| users\_aws\_auth | Usuários do IAM para interagirem com o Kubernetes. Obs: permite a visualização na console AWS dependendo do grupo escolhido. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| wait\_for\_cluster\_timeout | Valor em segundos para esperar o timeout do health check do cluster EKS. | `number` | `360` | no |

## Outputs

| Name | Description |
|------|-------------|
| eks\_cluster\_arn | ARN do cluster EKS |
| eks\_cluster\_certificate\_authority\_data | Certificado base64 decodificado. |
| eks\_cluster\_endpoint | Endpoint da API do Kubernetes. |
| eks\_cluster\_name | Nome do cluster EKS |
| eks\_cluster\_oidc\_provider\_arn | ARN do OIDC Provider do Kubernetes. |
| worker\_iam\_role\_arn | ARN da role dos workers |
| worker\_security\_group\_id | ID do SG dos workers |
<!-- END_TF_DOCS -->