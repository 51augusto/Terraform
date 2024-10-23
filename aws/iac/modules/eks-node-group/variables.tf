variable "region" {
  type        = string
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

variable "eks_cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "eks_cluster_ca_cert" {
  type        = string
  description = "Certificado base64 do cluster EKS"
}

variable "eks_cluster_endpoint" {
  type        = string
  description = "Endpoint do cluster EKS"
}

variable "worker_iam_role_arn" {
  type        = string
  description = "ARN da role que será utilizada pelos workers do node group."
}

variable "enable_monitoring" {
  type        = bool
  default     = false
  description = "Determina se o monitoramento detalhado será habilitado para as EC2 do node group."
}

variable "disk_size" {
  type        = number
  default     = 30
  description = "Tamanho do disco EBS das EC2 do Node Group"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Capacidade desejada para o Auto Scaling Group."
}

variable "max_capacity" {
  type        = number
  default     = 3
  description = "Capacidade máxima para o Auto Scaling Group."
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "Capacidade mínima para o Auto Scaling Group."
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.large"]
  description = "Tipos de instâncias EC2 do node group."
}

variable "cpu_credits" {
  type        = string
  default     = "standard"
  description = "Módo de créditos de CPU para instâncias T: `standard` ou `unlimited`."
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "Modelo de preço das instâncias. Valores permitidos: `ON_DEMAND` e `SPOT`"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags adicionais para todos os recursos do módulo."
}

variable "node_group_force_update" {
  type        = number
  default     = 0
  description = "Ao alterar essa variável, o node group será destruído e recriado."
}

variable "private_subnets_ids" {
  type        = list(string)
  description = "IDs das subnets privadas para workers do node group."
}

variable "node_group_suffix_name" {
  type        = string
  description = "Sufixo para o nome do Node Group. Será o valor do taint node/reserved-for. Na AWS o nome ficará nodes-$node_group_suffix_name"
}

variable "worker_security_group_id" {
  type        = string
  description = "ID do security group dos workers. Utilizar o mesmo dos nodes groups system. Usar output do módulo de cluster EKS."
}

variable "launch_template_version" {
  type        = string
  default     = "$Latest"
  description = "Versão do launch tamplate. Por padrão está setando a versão mais recente."
}

variable "max_unavailable" {
  type        = number
  default     = 1
  description = "Quantidade máxima de nós que podem ficar indisponíveis durante um update."
}

variable "k8s_version" {
  type        = string
  description = "Versão do Kubernetes do node group"
}