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
  description = "AWS Region"
}

variable "vpc_id" {
  type        = string
  description = "Identificador da VPC."
}

variable "subnets_ids" {
  type        = list(string)
  description = "Identificadores da subnets."
}

variable "encrypted" {
  type        = bool
  default     = true
  description = "Criptografar o sistema de arquivos."
}

variable "performance_mode" {
  type        = string
  default     = "generalPurpose"
  description = "Modo de performance do sistema de arquivos: `generalPurpose` ou `maxIO`."
}

variable "throughput_mode" {
  type        = string
  default     = "bursting"
  description = "Modo de taxa de transferência para o sistema de arquivos: `bursting` ou `provisioned`."
}

variable "provisioned_throughput" {
  type        = number
  default     = null
  description = "Taxa de transferência em MiB/s a ser utilizada caso `throughput_mode = provisioned`."
}

variable "transition_to_ia" {
  type        = string
  default     = null
  description = "Tempo para transição de arquivos para a classe de armazenamento IA: `AFTER_7_DAYS`, `AFTER_14_DAYS`, `AFTER_30_DAYS`, `AFTER_60_DAYS` ou `AFTER_90_DAYS`."
}

variable "transition_to_primary_storage_class" {
  type        = string
  default     = null
  description = "Política para transição de um arquivo do armazenamento IA para o armazenamento primário: `AFTER_1_ACCESS`."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup."
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = null
  description = "Lista de blocos CIDR que devem ter acesso ao EFS."
}

variable "access_points" {
  type = map(object({
    path        = string
    uid         = number
    gid         = number
    permissions = string
  }))
  default     = {}
  description = "Configurações dos Access Points do EFS. As chaves do mapa são os nomes dos APs."
}