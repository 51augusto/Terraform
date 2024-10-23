variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` "

  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, sandbox."
  }
}

variable "eks_cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "eks_cluster_region" {
  type        = string
  description = "Região do cluster EKS"
}

variable "eks_cluster_ca_cert" {
  type        = string
  description = "Certificado do cluster EKS"
}

variable "eks_cluster_oidc_provider_arn" {
  type        = string
  description = "ARN do OIDC Provider do cluster EKS"
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC que está o cluster EKS"
}

variable "worker_iam_role_arn" {
  type        = string
  description = "ARN da role dos Workers"
}

variable "kube_proxy_version" {
  type        = string
  default     = "v1.28.2-eksbuild.2"
  description = "Versão do kube-proxy gerenciado pela AWS."
}

variable "coredns_version" {
  type        = string
  default     = "v1.10.1-eksbuild.6"
  description = "Versão do coredns gerenciado pela AWS."
}

variable "vpc_cni_version" {
  type        = string
  default     = "v1.15.4-eksbuild.1"
  description = "Versão do vpc-cni gerenciado pela AWS."
}

variable "install_metrics_server" {
  type        = bool
  default     = true
  description = "Determina se o Metrics Server será instalado."
}

variable "install_kubedownscaler" {
  type        = bool
  default     = false
  description = "Determina se o KubeDownscaler será instalado."
}

variable "install_keda" {
  type        = bool
  default     = false
  description = "Determina se o KEDA será instalado."
}

variable "install_kube2iam" {
  type        = bool
  default     = true
  description = "Determina se o kube2iam será instalado."
}

variable "install_secrets_store_csi_driver" {
  type        = bool
  default     = true
  description = "Determina se o Secrets Store CSI Driver será instalado."
}

variable "install_ebs_csi_driver" {
  type        = bool
  default     = true
  description = "Determina se o EBS CSI Driver será instalado."
}

variable "install_efs_csi_driver" {
  type        = bool
  default     = true
  description = "Determina se o EFS CSI Driver será instalado."
}

variable "efs_csi_driver_version" {
  type        = string
  default     = "v1.7.2-eksbuild.1"
  description = "Versão do efs-csi-driver gerenciado pela AWS."
}

variable "install_cluster_autoscaler" {
  type        = bool
  default     = true
  description = "Determina se o Cluster Autoscaler será instalado."
}

variable "install_node_termination_handler" {
  type        = bool
  default     = false
  description = "Determina se o AWS Node Termination handler será instalado."
}

variable "node_termination_slack_webhook" {
  type        = string
  sensitive   = true
  description = "Webhook do Slack para receber notificações de Node Termination."
}

variable "install_prometheus_stack" {
  type        = bool
  default     = false
  description = "Determina se o Prometheus será instalado."
}

variable "prometheus_config" {
  type        = map(any)
  default     = {}
  description = "Opções de configuração para o Prometheus. Utilizado caso `install_prometheus_stack = true`"
}

variable "alertmanager_config" {
  type        = map(any)
  default     = {}
  description = "Opções de configuração para o Alert Manager. Utilizado caso `install_prometheus_stack = true`"
}

variable "install_promtail" {
  type        = bool
  default     = false
  description = "Determina se o Grafana Promtail será instalado."
}

variable "install_ingress_controller_external" {
  type        = bool
  default     = false
  description = "Determina se o AWS Load Balancer Controller será instalado, em conjunto com um ALB público."
}

variable "install_ingress_controller_internal" {
  type        = bool
  default     = false
  description = "Determina se o AWS Load Balancer Controller será instalado, em conjunto com um ALB privado."
}

variable "default_backend_image" {
  type        = string
  default     = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/static-websites:default-backend"
  description = "Imagem para o Default Backend dos Ingresses"
}

variable "external_alb_config" {
  type        = map(any)
  default     = {}
  description = "Opções de configuração para o ALB externo. Utilizado caso `install_ingress_controller_external = true`"
}

variable "internal_alb_config" {
  type        = map(any)
  default     = {}
  description = "Opções de configuração para o ALB interno. Utilizado caso `install_ingress_controller_internal = true`"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todos os recursos."
}