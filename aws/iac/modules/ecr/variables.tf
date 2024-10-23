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
  description = "Nome do repositório ECR."
}

variable "release_tag_prefixes" {
  type        = list(string)
  default     = ["v"]
  description = "Prefixos das tags de release."
}

variable "max_release_tags" {
  type        = number
  default     = 20
  description = "Numero máximo de tags de release a serem mantidas."
}

variable "read_principal" {
  type = map(any)
  default = {
    "AWS" : [
      "arn:aws:iam::880974337725:root", #workload-dev
      "arn:aws:iam::849598278174:root", #workload-cer
      "arn:aws:iam::241290613667:root", #workload-hml
      "arn:aws:iam::899836677866:root"  #workload-prd
    ]
  }
  description = "Principal da política de leitura no repositório ECR. Padrão: contas de Workload."
}

variable "create_pull_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de pull de imagens."
}