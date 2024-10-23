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

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Ativa a proteção contra deleção do Cognito User Pool."
}

variable "endpoint_domain" {
  type        = string
  description = "Domínio para o endpoint de autenticação."
}

variable "endpoint_certificate_arn" {
  type        = string
  description = "ARN do certificado para o endpoint de autenticação."
}

variable "clients" {
  type        = map(any)
  description = "Clientes da API."
}

variable "resources" {
  type        = map(any)
  default     = {}
  description = "Recursos da API."
}