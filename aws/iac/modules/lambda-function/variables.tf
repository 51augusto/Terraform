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

variable "runtime" {
  type        = string
  description = "Tipo de runtime."
  validation {
    condition     = contains(["java11", "java17", "python3.9", "python3.10", "python3.11", "nodejs14.x", "docker"], var.runtime)
    error_message = "Valor de runtime inválido. Valores válidos: `java11`, `java17`, `python3.9`, `python3.10`, `python3.11`, `nodejs14.x`, `docker`."
  }
}

variable "architectures" {
  type        = list(string)
  default     = ["x86_64"]
  description = "Tipos de arquitetura de CPU."
}

variable "image_uri" {
  type        = string
  default     = null
  description = "URI da imagem caso `runtime=\"docker\"`."
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "ARNs de versões de Lambda Layers a serem atachadas à função."
}

variable "vpc_config" {
  type = object({
    vpc_id             = string
    subnet_ids         = list(string)
    create_default_sg  = bool
    security_group_ids = list(string)
  })
  default     = null
  description = "Configuração de VPC."
}

variable "file_system_config" {
  type = object({
    arn              = string
    local_mount_path = string
  })
  default     = null
  description = "Configuração de EFS."
}

variable "dead_letter_config" {
  type = object({
    target_arn = string
  })
  default     = null
  description = "Configuração de Dead Letter."
}

variable "tracing_config" {
  type = object({
    mode = string
  })
  default     = null
  description = "Configuração de Tracing."
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "ARNs de políticas a serem anexadas à Role padrão da função."
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

variable "create_ops_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para ferramentas de Operações."
}

variable "create_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações."
}