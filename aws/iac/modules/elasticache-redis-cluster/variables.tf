variable "component_name" {
  type        = string
  description = "Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED`"
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox`"
  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environment inválido. Valores válidos: `dev`, `cer`, `hml`, `prd`, `shared`, `sandbox`."
  }
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Região AWS."
}

variable "name" {
  type        = string
  description = "Nome do cluster redis a ser criado."
  validation {
    condition     = length(var.name) <= 40
    error_message = "Nome tem que ter até 40 characteres."
  }
}

variable "description" {
  type        = string
  description = "Descrição do cluster redis a ser criado."
}

variable "port" {
  type        = number
  description = "Número da porta em que cada cache node vai aceitar conexões."
  default     = 6379
}

variable "node_type" {
  type        = string
  description = "Instância a ser usado no cluster."
}

variable "number_cache_clusters" {
  type        = number
  description = "Número de clusters (primary e replicas) que serão criados."
  default     = 1
}

variable "redis_engine_version" {
  type        = string
  description = "Número da versão do redis que será utilizada no cluster."
  default     = "6.x"
}

variable "subnet_group_name" {
  type        = string
  description = "Nome do cache subnet group a ser usado pelo cluster."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC"
}

variable "security_group_ids" {
  type        = set(string)
  default     = null
  description = "Segurity group para ser usado no cluster."
}

variable "inbound_rules" {
  type = list(object({
    description = string,
    cidr_blocks = list(string)
  }))
  default     = []
  description = "Lista de regras de entrada para liberação de IPs."
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Quando essa opção é habilitada para `true`, todas as mudanças no Elasticache ocorrem **imediatamente** . Caso fique desabilitada, as mudanças solicitadas ocorrerão na próxima janela de manutenção (Recomendado para ambiente de PRD)."
}

variable "maintenance_window" {
  type        = string
  default     = "sun:03:00-sun:04:00"
  description = "Janela de manutenção para implementação de atualizações, por exemplo."
}

variable "snapshot_window" {
  type        = string
  default     = "02:00-03:00"
  description = "Janela para realização de snapshot do cluster."
}

variable "snapshot_retention_limit" {
  type        = number
  default     = 0
  description = "Número de dias que o ElastiCache vai reter automaticamente os snapshots do cluster antes de deletá-las."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}

variable "pg_family" {
  type        = string
  default     = "redis6.x"
  description = "Família do grupo de parâmetros do elasticache."
}

variable "parameters" {
  type = list(object({
    name  = string
    value = any
  }))
  description = "Lista de parâmetros a serem configurados no parameter group."
  default     = null
}

