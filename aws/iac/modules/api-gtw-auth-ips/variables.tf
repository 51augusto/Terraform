variable "component_name" {
  type        = string
  description = "Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED`"
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox`"
  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "network", "logs", "audit", "backup", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, network, logs, audit, backup, sandbox."
  }
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "name" {
  type        = string
  description = "Nome do Authorizer."
}

variable "api_id" {
  type        = string
  description = "Ientificador da API que será associada ao Authorizer."
}

variable "ip_range" {
  type        = list(string)
  description = "Lista de IPs e/ou CIDRs autorizados."
}

variable "cache_ttl" {
  type        = number
  default     = 600
  description = "Tempo em segundos para caching da autorização."
}

variable "logging_retention" {
  type        = number
  default     = 14
  description = "Tempo em dias para retenção de logs no CloudWatch."
}
