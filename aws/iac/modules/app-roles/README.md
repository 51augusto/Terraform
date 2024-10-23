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
| [aws_iam_policy.cicd_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ops_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ops_start_stop_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cicd_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_single_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ops_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | Nome da aplicação. | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| cicd\_max\_session\_duration | Tempo máximo de duração de sessão da Role de CI/CD em segundos. | `number` | `3600` | no |
| cicd\_polices\_arns | Lista de ARNs das policies para uma Role a ser utilizada em jobs de CI/CD. | `list(string)` | `[]` | no |
| ec2\_polices\_arns | Lista de ARNs das policies para uma Role a ser utilizada em uma EC2. | `list(string)` | `null` | no |
| ecs\_applications | Map de aplicações para serem criadas Roles que serão utilizadas no ECS. Exemplo:<br><br>  ecs\_applications = {<br>    app-1 = {<br>    app\_name = "backend"<br>    ecs\_policies\_arns = []<br>    },<br>    app-2 = {<br>    app\_name = "api-main"<br>    ecs\_policies\_arns = []<br>    }<br>  } | <pre>map(object({<br>    app_name          = string<br>    ecs_policies_arns = list(string)<br>  }))</pre> | `{}` | no |
| eks\_applications | Map de aplicações para serem criadas Roles que serão utilizadas no EKS. Exemplo:<br><br>  eks\_applications = {<br>    app-1 = {<br>    app\_name = "backend"<br>    eks\_policies\_arns = []<br>    },<br>    app-2 = {<br>    app\_name = "api-main"<br>    eks\_policies\_arns = []<br>    }<br>  } | <pre>map(object({<br>    app_name          = string<br>    eks_policies_arns = list(string)<br>  }))</pre> | `{}` | no |
| eks\_polices\_arns | Lista de ARNs das policies para uma Role a ser utilizada no EKS. Para Roles específicas por aplicação, utilizar `eks_applications`. | `list(string)` | `null` | no |
| ops\_max\_session\_duration | Tempo máximo de duração de sessão da Role de Operações em segundos. | `number` | `3600` | no |
| ops\_policies\_arns | Lista de ARNs das policies para uma Role a ser utilizada em jobs de Ferramentas de Operações. | `list(string)` | `[]` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cicd\_role | Role para CI/CD. |
| ec2\_role | Role para EC2. |
| ecs\_role | Role para aplicações ECS. |
| eks\_role | Role para aplicações EKS. |
| eks\_single\_role | Role para EKS. |
| ops\_role | Role para Operações. |
<!-- END_TF_DOCS -->