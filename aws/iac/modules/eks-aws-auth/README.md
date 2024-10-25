<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.cicd_iac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_iam_roles.app_editor](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.app_ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.break_glass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.cicd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.extra_sso_auths](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.ops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.sso_admins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_names\_for\_k8s\_cicd | Lista de nomes das aplicações baseado no `component_name` que será preenchido no Terraform. Essa variável está sendo utilizada para criar um usuário de CI/CD no Kubernetes via ConfigMap `aws-auth` | `list(string)` | n/a | yes |
| app\_names\_for\_k8s\_ops | Lista de nomes das aplicações baseado no `component_name` que será preenchido no Terraform. Essa variável está sendo utilizada para criar um usuário de Operações no Kubernetes via ConfigMap `aws-auth` | `list(string)` | n/a | yes |
| app\_names\_for\_k8s\_users | Lista de nomes das aplicações baseado no nome do permissions sets SSO. O nome do permission sets tem o padrão de nome: $APLICACAO\_RO ou $APLICACAO\_EDITOR. Passar o valor de $APLICACAO. Essa variável está sendo utilizada para criar um usuário no Kubernetes via ConfigMap `aws-auth` | `list(string)` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| region | Região AWS | `string` | n/a | yes |
| extra\_auths | Mapeamentos de autorização extras que serão aplicados junto aos automáticos. | <pre>list(object({<br/>    rolearn  = string<br/>    username = string<br/>  }))</pre> | `[]` | no |
| extra\_sso\_auths | Mapeamentos de autorização extras do SSO que serão aplicados. | <pre>list(object({<br/>    permission_set_name = string<br/>    username            = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| roles\_aws\_auth | Lista de roles para serem configuradas no ConfigMap `aws-auth` . |
<!-- END_TF_DOCS -->