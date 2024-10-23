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
  description = "Nome do bucket."
}

variable "sse_type" {
  type        = string
  default     = "SSE-KMS"
  description = "Tipo de encriptação Server-Side a ser utilizada. Valores permitidos: `SSE-KMS` e `SSE-S3`. Ref.: https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html"
  validation {
    condition     = contains(["SSE-KMS", "SSE-S3"], var.sse_type)
    error_message = "Tipo de encriptação inválido. Valores válidos: SSE-KMS e SSE-S3."
  }
}

variable "versioning" {
  type    = string
  default = "Disabled"
  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning)
    error_message = "Valor para versioning inválido. Valores válidos: Enabled, Suspended ou Disabled."
  }
  description = "Habilita versionamento de objetos no bucket, valores válidos: `Enabled`, `Suspended` ou `Disabled`."
}

variable "expiration_rules" {
  type = list(object({
    prefix : string,
    days : number
  }))
  default     = []
  description = "Regras de expiração de objetos do bucket."
}

variable "transition_rules" {
  type = list(object({
    prefix : string,
    days : number,
    storage_class : string
  }))
  default     = []
  description = "Regras de transição de Storage Class de objetos do bucket."
}

variable "noncurr_expiration_rules" {
  type = list(object({
    prefix : string,
    days : number
  }))
  default     = []
  description = "Regras de expiração de versões não atuais de objetos do bucket."
}

variable "noncurr_transition_rules" {
  type = list(object({
    prefix : string,
    days : number,
    storage_class : string
  }))
  default     = []
  description = "Regras de transição de Storage Class de versões não atuais de objetos do bucket."
}

variable "cors_rules" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default     = []
  description = "Regras de cors que serão aplicada."
}

variable "create_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}

variable "public_bucket" {
  type        = bool
  default     = false
  description = "Expõe o bucket para toda a internet. Habilitar APENAS em casos necessários. Necessário usar a criptografia SSE-S3."
}

variable "object_lock_configuration" {
  type = object({
    days = number
    mode = string
  })
  default     = null
  description = <<EOF

  Mode: Modo de retenção do Object Lock padrão que você deseja aplicar a novos objetos armazenados no bucket especificado. Valores válidos: GOVERNANCE , COMPLIANCE
  Para utilizar esse modo é necessario que o versioning do bucket precisa estar enabled: versioning = "Enabled"

  - Governance: objeto fica impossibilitado de ser deletado após o período determinado, porém uma
  identidade IAM com algumas permissões específicas de S3 ainda consegue fazer um bypass dessa configuração.

  - Compliance: objeto fica impossibilitado de ser deletado após o período determinado. 
  Nenhum usuário, incluindo o Root, consegue deletar os arquivos durante o período de retenção configurado.

  EOF
}