variable "component_name" {
  type        = string
  description = "Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED`"
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox`"
  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "network", "logs", "audit", "backup", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, network, logs, audit, backup, sandbox ."
  }
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Região AWS."
}

variable "name" {
  type        = string
  description = "Nome da fila SQS."
}

variable "fifo" {
  type        = bool
  default     = false
  description = "Define se a fila é FIFO"
}

variable "content_based_deduplication" {
  type        = bool
  default     = false
  description = "Configura deduplicação das SQS padrão false"
}

variable "delay_seconds" {
  type        = number
  default     = 0
  description = "Tempo de delay da fila SQS em segundos"
}

variable "max_message_size" {
  type        = number
  default     = 2048
  description = "Tamanho maximo das messagens no SQS"
}

variable "message_retention_seconds" {
  type        = number
  default     = 604800
  description = "Tempo de retenção das menssagens no SQS (padrão 7 dias)"
}

variable "dlq_message_retention_seconds" {
  type        = number
  default     = 1209600
  description = "Tempo de retenção das menssagens na DLQ (padrão 14 dias)"
}

variable "visibility_timeout_seconds" {
  type        = number
  default     = 30
  description = "Timeout de visibilidade padrão da mensagem"
}

variable "dlq_visibility_timeout_seconds" {
  type        = number
  default     = 30
  description = "Timeout de visibilidade padrão da mensagem na DLQ"
}

variable "max_receive_count" {
  type        = number
  default     = 4
  description = "Numero máximo de retentativas antes da mensagem ser enviada à DLQ"
}

variable "create_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações."
}