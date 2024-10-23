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
  description = "Nome da tabela."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "Modo de cobrança da tabela: PAY_PER_REQUEST ou PROVISIONED."
}

variable "read_capacity" {
  type        = number
  default     = null
  description = "Número de unidades de leitura da tabela."
}

variable "write_capacity" {
  type        = number
  default     = null
  description = "Número de unidades de escrita da tabela."
}

variable "table_class" {
  type        = string
  default     = "STANDARD"
  description = "Classe de armazenamento da tabela: STANDARD ou STANDARD_INFREQUENT_ACCESS."
}

variable "hash_key" {
  type = object({
    name : string,
    type : string
  })
  default = {
    name : "ID",
    type : "N"
  }
  description = "Chave primária da tabela."
}

variable "range_key" {
  type = object({
    name : string,
    type : string
  })
  default     = null
  description = "Chave para ordenação da tabela."
}

variable "attributes" {
  type = list(object({
    name : string,
    type : string
  }))
  default     = []
  description = "Lista de atributos da tabela."
}

variable "ttl" {
  type = object({
    enabled : bool,
    attribute : string
  })
  default = {
    enabled : false,
    attribute : "ttl"
  }
  description = "Configuração de TTL da tabela."
}

variable "local_indexes" {
  type = list(object({
    name : string,
    range_key : string,
    projection_type : string,
    non_key_attributes : list(string)
  }))
  default     = []
  description = "Lista de índices locais."
}

variable "global_indexes" {
  type = list(object({
    name : string,
    read_capacity : number,
    write_capacity : number,
    hash_key : string,
    range_key : string,
    projection_type : string,
    non_key_attributes : list(string)
  }))
  default     = []
  description = "Lista de índices locais."
}

variable "create_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações."
}