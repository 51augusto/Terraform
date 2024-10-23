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
  description = "Nome da função."
}

variable "description" {
  type        = string
  default     = null
  description = "Descrição da função."
}

variable "architectures" {
  type        = list(string)
  default     = ["x86_64"]
  description = "Tipos de arquitetura de CPU."
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "ARNs de versões de Lambda Layers a serem atachadas à função."
}

variable "runtime" {
  type        = string
  default     = "nodejs14.x"
  description = "Tipo de runtime."
}

variable "filename" {
  type        = string
  default     = null
  description = "Path para o pacote com o código da função."
}

variable "handler" {
  type        = string
  default     = "index.handler"
  description = "Handler da função."
}

variable "logging_retention" {
  type        = number
  default     = 14
  description = "Tempo em dias para retenção de logs no CloudWatch."
}

variable "create_cicd_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para CI/CD."
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "ARNs de políticas a serem anexadas à Role padrão da função."
}
