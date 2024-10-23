variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "component_name" {
  type        = string
  description = "Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED`"
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` "

  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, sandbox ."
  }
}

variable "k8s_version" {
  type        = string
  description = "Versão do Kubernetes no cluster EKS."
}

variable "accounts_aws_auth" {
  type        = list(string)
  default     = []
  description = "Lista de contas AWS para interagirem com o Kubernetes."
}

variable "roles_aws_auth" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "Roles do IAM para interagirem com o Kubernetes. Obs: permite a visualização na console AWS dependendo do grupo escolhido."
}

variable "users_aws_auth" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "Usuários do IAM para interagirem com o Kubernetes. Obs: permite a visualização na console AWS dependendo do grupo escolhido."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC."
}

variable "private_subnets_ids" {
  type        = list(string)
  description = "IDs das subnets privadas para o cluster e workers Kubernetes."
}

variable "node_groups_enable_monitoring" {
  type        = bool
  default     = false
  description = "Determina se o monitoramento para os node groups será habilitado ou não."
}

variable "node_groups_disk_size" {
  type        = number
  default     = 30
  description = "Tamanho dos discos dos node groups."
}

variable "system_node_group_force_update" {
  type        = number
  default     = 0
  description = "Ao alterar essa variável, o node group de sistema será destruído e recriado."
}

variable "system_node_group_config" {
  type        = any
  description = "Configurações do node group system"
}

variable "cluster_enabled_log_types" {
  type        = list(string)
  default     = []
  description = "Lista com os tipos de logs que serão habilitados para o cluster EKS. Valores válidos: `api`, `audit`, `authenticator`, `controllerManager`, `scheduler`"
}

variable "cluster_log_retention_in_days" {
  type        = number
  default     = 30
  description = "Retenção dos logs do Cluster EKS em dias ( `api`, `audit`, `authenticator`, `controllerManager`, `scheduler` ) ."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags adicionais para todos os recursos do módulo."
}

variable "wait_for_cluster_timeout" {
  type        = number
  default     = 360
  description = "Valor em segundos para esperar o timeout do health check do cluster EKS."
}

variable "max_unavailable" {
  type        = number
  default     = 1
  description = "Quantidade máxima de nós que podem ficar indisponíveis durante um update."
}

variable "ng_system_k8s_version" {
  type        = string
  description = "Versão do Kubernetes do node group system"
}