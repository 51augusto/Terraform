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
  description = "Nome da API"
}

variable "description" {
  type        = string
  default     = null
  description = "Descrição da API"
}

variable "domain_name" {
  type        = string
  description = "Nome do Domínio da API"
}

variable "certificate_arn" {
  type        = string
  description = "ARN do certificado do Domínio da API"
}

variable "disable_execute_api_endpoint" {
  type        = bool
  default     = true
  description = "Desabilita chamadas à API através do endpoint padrão"
}

variable "enable_access_log" {
  type        = bool
  default     = false
  description = "Habilita o registro de Access Logs"
}

variable "logging_retention" {
  type        = number
  default     = 14
  description = "Tempo em dias para retenção de Access Logs no CloudWatch"
}

variable "logging_format" {
  type        = string
  default     = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId"
  description = "Formato dos Access Logs, ref.: https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-logging.html"
}

variable "cors_configuration" {
  type = object({
    allow_credentials = bool
    allow_headers     = list(string)
    allow_methods     = list(string)
    allow_origins     = list(string)
    expose_headers    = list(string)
    max_age           = number
  })
  default     = null
  description = "Configurações de CORS da API"
}