variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` "

  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, sandbox ."
  }
}

variable "mandatory_tags" {
  type = object({ Environment = string, IAC = bool })
  default = {
    Environment = "shared", IAC = true
  }
  description = "Tags obrigatórias para todos os recursos."

  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.mandatory_tags["Environment"])
    error_message = "Valor para Environmet inválido. Valores válidos: dev, cer, hml, prd, shared, sandbox ."
  }
}

variable "map_migration_tags" {
  type        = map(string)
  description = "Tags para serem aplicadas em todos os recursos (programa de incentivo de migração MAP)."

  default = {
    map-migrated = "d-server-01oiau1h5afqhv"
  }
}

variable "account_name" {
  type        = string
  description = "Nome da conta AWS"
}