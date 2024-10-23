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

variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID da VPC onde os serviços serão alocados, caso não seja especificada na definição do próprio serviço."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "IDs das subnets a serem utilizadas pelos serviços do cluster, caso não sejam especificadas na definição do próprio serviço."
}

variable "secret_arns" {
  type        = list(string)
  default     = []
  description = "ARNs dos secrets utilizados pelos serviços do cluster, caso não sejam especificadas na definição do próprio serviço."
}

variable "spot" {
  type        = bool
  default     = true
  description = "Indica se serviços devem usar Fargate Spot, caso não sejam especificado na definição do próprio serviço."
}

variable "services" {
  type        = map(any)
  default     = {}
  description = "Serviços a serem instalados no cluster."
}

variable "create_cicd_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para CI/CD."
}