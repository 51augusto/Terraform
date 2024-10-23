variable "component_name" {
  type        = string
  description = "Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED`"
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox`"
  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environment inválido. Valores válidos: `dev`, `cer`, `hml`, `prd`, `shared`, `sandbox`."
  }
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Região AWS."
}

variable "name" {
  type        = string
  description = "Nome do cluster OpenSearch a ser criado."
}

variable "engine_version" {
  type        = string
  description = "Versão da engine do OpenSearch."
}

variable "advanced_options" {
  type        = map(string)
  default     = {}
  description = "Opções de configuração avançada do OpenSearch."
}

variable "dedicated_masters" {
  type = object({
    count = number
    type  = string
  })
  default     = null
  description = "Configuração para nós mestres dedicados. Ignorado se nulo."
}

variable "instance_type" {
  type        = string
  description = "Tipo de instância dos nós do cluster."
}

variable "instance_count" {
  type        = string
  description = "Quantidade de nós do cluster."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Executar cluster em MultiAZ."
}

variable "storage_type" {
  type        = string
  default     = "gp3"
  description = "Tipo de disco dos nós do cluster."
  validation {
    condition     = contains(["gp2", "gp3"], var.storage_type)
    error_message = "Tipo de disco invalido. Valores aceitos: gp2, gp3."
  }
}

variable "storage_size" {
  type        = number
  default     = 20
  description = "Alocação de storage para cada nó do cluster."
}

variable "storage_iops" {
  type        = number
  default     = 3000
  description = "Quantidade de IOPS provisionados para os discos dos nós do cluster. Valores aceitos: 3000–16000 IOPS."
  validation {
    condition     = var.storage_iops == null ? true : (var.storage_iops >= "3000" && var.storage_iops <= "16000")
    error_message = "Quantidade de IOPS inválido. Valores aceitos: 3000–16000 IOPS."
  }
}

variable "storage_throughput" {
  type        = number
  default     = 125
  description = "Quantidade de MiB/s provisionados para os discos dos nós do cluster. Valores aceitos: 125–593 MiB/s."
  validation {
    condition     = var.storage_throughput == null ? true : (var.storage_throughput >= "125" && var.storage_throughput <= "593")
    error_message = "Tipo de storage_throughput inválido. Valores aceitos: 125–593."
  }
}

variable "endpoint_domain" {
  type        = string
  description = "Domíno do endpoint de acesso ao cluster."
}

variable "endpoint_certificate_arn" {
  type        = string
  description = "Certificado para o endpoint de acesso ao cluster."
}

variable "endpoint_tls_policy" {
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
  description = "Política de TLS do endpoint de acesso ao cluster."
  validation {
    condition     = contains(["Policy-Min-TLS-1-0-2019-07", "Policy-Min-TLS-1-2-2019-07"], var.endpoint_tls_policy)
    error_message = "Valor para TLS Policy inválido. Valores válidos: `Policy-Min-TLS-1-0-2019-07` e `Policy-Min-TLS-1-2-2019-07`."
  }
}

variable "enable_auto_tune" {
  type        = bool
  default     = true
  description = "Indica se deve habilitar o Auto Tune no cluster."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC."
}

variable "subnet_ids" {
  type        = set(string)
  description = "Subnets para o cluster."
}

variable "security_group_ids" {
  type        = set(string)
  default     = null
  description = "Segurity group para o cluster."
}

variable "inbound_rules" {
  type = list(object({
    description = string
    cidr_blocks = list(string)
  }))
  default     = []
  description = "Lista de regras de entrada para liberação de IPs."
}

variable "off_peak_window_start" {
  type = object({
    hours   = string
    minutes = string
  })
  default = {
    hours   = "01"
    minutes = "30"
  }
  description = "Início da janela de 10 horas de baixo consumo do cluster em UTC. Padrão: `22:30-08:30` Brasília."
}

variable "master_username" {
  type        = string
  description = "Username do usuário master da Base."
}

variable "master_password" {
  type        = string
  sensitive   = true
  description = "Senha do usuário master da Base."
}

variable "use_default_kms" {
  type        = bool
  default     = false
  description = "Indica se deve utilizar a chave KMS padrão ou criar uma dedicada."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup."
}

variable "logging_retention" {
  type        = number
  default     = 14
  description = "Tempo em dias para retenção de logs no CloudWatch."
}

variable "saml_config" {
  type = object({
    entity_id               = string
    metadata_content        = string
    master_backend_role     = string
    master_username         = string
    roles_key               = string
    session_timeout_minutes = number
    subject_key             = string

  })
  default     = null
  description = "Configurações de SAML"
}