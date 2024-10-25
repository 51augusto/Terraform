<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |
| helm | >= 2.0.0 |
| kubernetes | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.coredns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.efs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_policy.aws_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.keda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.efs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.keda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.keda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.alb_ingress_external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.alb_ingress_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [helm_release.aws_lb_ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.kube2iam](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.secrets_store_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_api_service.v1_beta1_metrics_k8s_io](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/api_service) | resource |
| [kubernetes_cluster_role.kube_downscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.secrets_store_csi_provider_aws_cluster_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.system_aggregated_metrics_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.system_metrics_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.kube_downscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.metrics_server_system_auth_delegator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.secrets_store_csi_provider_aws_cluster_rolebinding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.system_metrics_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.kube_downscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_daemonset.secrets_store_csi_provider_aws](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/daemonset) | resource |
| [kubernetes_deployment.aws_lb_ingress_default_backend](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_deployment.kube_downscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_deployment.metrics_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.alertmanager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.aws_lb_ingress_external](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.aws_lb_ingress_internal](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.prometheus](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.kube_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.kube_keda](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.kube_logging](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.kube_monitoring](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role_binding.metrics_server_auth_reader](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service.aws_lb_ingress_external](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.aws_lb_ingress_internal](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.metrics_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.kube_downscaler](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.metrics_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.secrets_store_csi_provider_aws](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_storage_class.ebs_storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [kubernetes_storage_class.efs_storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.keda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prometheus_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| eks\_cluster\_ca\_cert | Certificado do cluster EKS | `string` | n/a | yes |
| eks\_cluster\_name | Nome do cluster EKS | `string` | n/a | yes |
| eks\_cluster\_oidc\_provider\_arn | ARN do OIDC Provider do cluster EKS | `string` | n/a | yes |
| eks\_cluster\_region | Região do cluster EKS | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| node\_termination\_slack\_webhook | Webhook do Slack para receber notificações de Node Termination. | `string` | n/a | yes |
| vpc\_id | ID da VPC que está o cluster EKS | `string` | n/a | yes |
| worker\_iam\_role\_arn | ARN da role dos Workers | `string` | n/a | yes |
| alertmanager\_config | Opções de configuração para o Alert Manager. Utilizado caso `install_prometheus_stack = true` | `map(any)` | `{}` | no |
| coredns\_version | Versão do coredns gerenciado pela AWS. | `string` | `"v1.10.1-eksbuild.6"` | no |
| default\_backend\_image | Imagem para o Default Backend dos Ingresses | `string` | `"788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/static-websites:default-backend"` | no |
| efs\_csi\_driver\_version | Versão do efs-csi-driver gerenciado pela AWS. | `string` | `"v1.7.2-eksbuild.1"` | no |
| external\_alb\_config | Opções de configuração para o ALB externo. Utilizado caso `install_ingress_controller_external = true` | `map(any)` | `{}` | no |
| install\_cluster\_autoscaler | Determina se o Cluster Autoscaler será instalado. | `bool` | `true` | no |
| install\_ebs\_csi\_driver | Determina se o EBS CSI Driver será instalado. | `bool` | `true` | no |
| install\_efs\_csi\_driver | Determina se o EFS CSI Driver será instalado. | `bool` | `true` | no |
| install\_ingress\_controller\_external | Determina se o AWS Load Balancer Controller será instalado, em conjunto com um ALB público. | `bool` | `false` | no |
| install\_ingress\_controller\_internal | Determina se o AWS Load Balancer Controller será instalado, em conjunto com um ALB privado. | `bool` | `false` | no |
| install\_keda | Determina se o KEDA será instalado. | `bool` | `false` | no |
| install\_kube2iam | Determina se o kube2iam será instalado. | `bool` | `true` | no |
| install\_kubedownscaler | Determina se o KubeDownscaler será instalado. | `bool` | `false` | no |
| install\_metrics\_server | Determina se o Metrics Server será instalado. | `bool` | `true` | no |
| install\_node\_termination\_handler | Determina se o AWS Node Termination handler será instalado. | `bool` | `false` | no |
| install\_prometheus\_stack | Determina se o Prometheus será instalado. | `bool` | `false` | no |
| install\_promtail | Determina se o Grafana Promtail será instalado. | `bool` | `false` | no |
| install\_secrets\_store\_csi\_driver | Determina se o Secrets Store CSI Driver será instalado. | `bool` | `true` | no |
| internal\_alb\_config | Opções de configuração para o ALB interno. Utilizado caso `install_ingress_controller_internal = true` | `map(any)` | `{}` | no |
| kube\_proxy\_version | Versão do kube-proxy gerenciado pela AWS. | `string` | `"v1.28.2-eksbuild.2"` | no |
| prometheus\_config | Opções de configuração para o Prometheus. Utilizado caso `install_prometheus_stack = true` | `map(any)` | `{}` | no |
| tags | Tags para todos os recursos. | `map(string)` | `{}` | no |
| vpc\_cni\_version | Versão do vpc-cni gerenciado pela AWS. | `string` | `"v1.15.4-eksbuild.1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->