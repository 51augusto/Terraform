# Kubernetes Application Namespace

Módulo Terraform para provisionamento dos recursos básicos do Namespace de uma aplicação:

- Namespace
- Cota de recursos de computação (CPU e memória).
- Cota de recursos de armazenamento (PVC).
- Definição de `Requests` e `Limits` padrões.
- Service Account para processos de operação: `ops`.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |
| kubernetes | >= 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eks_sa_secrets_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_sa_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_sa_secrets_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [kubernetes_limit_range_v1.container_default_resources](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/limit_range_v1) | resource |
| [kubernetes_namespace_v1.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_resource_quota_v1.compute_quota](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/resource_quota_v1) | resource |
| [kubernetes_resource_quota_v1.storage_quota](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/resource_quota_v1) | resource |
| [kubernetes_role_binding_v1.app_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.cicd_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.editor_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.ops_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.ro_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_v1.app_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_role_v1.cicd_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_role_v1.editor_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_role_v1.ops_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_role_v1.ro_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_service_account_v1.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | Nome da aplicação. | `string` | n/a | yes |
| area | Área Owner da aplicação. Ex.: corp, rh, operacoes. | `string` | n/a | yes |
| environment | Identificador do ambiente. | `string` | n/a | yes |
| oidc\_provider\_arn | ARN do OIDC Provider do cluster. | `string` | n/a | yes |
| app\_permission\_rules | Regras de permissionamento para a Service Account da aplicação. | <pre>list(object({<br>    api_groups = list(string)<br>    verbs      = list(string)<br>    resources  = list(string)<br>  }))</pre> | `null` | no |
| app\_secrets\_arns | ARNs dos secrets que devem ser acessíveis pela aplicação. | `list(string)` | `null` | no |
| cicd\_permission\_rules | Regras de permissionamento para a Service Account de CI/CD. | <pre>list(object({<br>    api_groups = list(string)<br>    verbs      = list(string)<br>    resources  = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "api_groups": [<br>      "",<br>      "apps",<br>      "batch",<br>      "extensions",<br>      "autoscaling",<br>      "networking.k8s.io",<br>      "secrets-store.csi.x-k8s.io",<br>      "monitoring.coreos.com",<br>      "keda.sh"<br>    ],<br>    "resources": [<br>      "configmaps",<br>      "cronjobs",<br>      "deployments",<br>      "deployments/scale",<br>      "events",<br>      "ingresses",<br>      "jobs",<br>      "pods",<br>      "pods/attach",<br>      "pods/exec",<br>      "pods/log",<br>      "pods/portforward",<br>      "secrets",<br>      "services",<br>      "persistentvolumeclaims",<br>      "horizontalpodautoscalers",<br>      "secretproviderclasses",<br>      "prometheusrules",<br>      "podmonitors",<br>      "servicemonitors",<br>      "probes",<br>      "scaledjobs",<br>      "scaledobjects",<br>      "triggerauthentications"<br>    ],<br>    "verbs": [<br>      "create",<br>      "delete",<br>      "get",<br>      "list",<br>      "patch",<br>      "update",<br>      "watch"<br>    ]<br>  }<br>]</pre> | no |
| container\_default\_resources | Definição padrão de recursos dos containers. | `any` | <pre>{<br>  "cpu": {<br>    "limit": "1",<br>    "request": "200m"<br>  },<br>  "memory": {<br>    "limit": "512Mi",<br>    "request": "128Mi"<br>  }<br>}</pre> | no |
| labels | Labels a serem aplicadas aos recursos. | `map(string)` | `{}` | no |
| ops\_permission\_rules | Regras de permissionamento para a Service Account de Operações. | <pre>list(object({<br>    api_groups = list(string)<br>    verbs      = list(string)<br>    resources  = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "api_groups": [<br>      "",<br>      "apps",<br>      "batch",<br>      "extensions",<br>      "secrets-store.csi.x-k8s.io"<br>    ],<br>    "resources": [<br>      "events",<br>      "jobs",<br>      "pods",<br>      "pods/attach",<br>      "pods/exec",<br>      "pods/log",<br>      "pods/portforward",<br>      "secretproviderclasses"<br>    ],<br>    "verbs": [<br>      "create",<br>      "delete",<br>      "get",<br>      "list",<br>      "patch",<br>      "update",<br>      "watch"<br>    ]<br>  },<br>  {<br>    "api_groups": [<br>      ""<br>    ],<br>    "resources": [<br>      "namespaces"<br>    ],<br>    "verbs": [<br>      "get",<br>      "patch"<br>    ]<br>  }<br>]</pre> | no |
| quota | Cota de recursos totais do namespace. | `any` | <pre>{<br>  "cpu": {<br>    "limit": "2",<br>    "request": "1"<br>  },<br>  "memory": {<br>    "limit": "2Gi",<br>    "request": "1Gi"<br>  },<br>  "storage": "0"<br>}</pre> | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| eks\_sa\_role | Role da service account criada para a aplicação. |
| k8s\_namespace | Nome do namespace criado para a aplicação. |
<!-- END_TF_DOCS -->