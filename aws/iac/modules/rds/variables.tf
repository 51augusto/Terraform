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
  description = "Nome da base a ser criada."
}

variable "type" {
  type        = string
  description = "Tipo da base de dados: `mysql`, `postgresql`, `mssql-ex`, `mssql-se`, `mssql-web`"
  validation {
    condition     = contains(["mysql", "postgresql", "mssql-ex", "mssql-se", "mssql-web"], var.type)
    error_message = "Tipo de base inválido."
  }
}

variable "engine_version" {
  type        = string
  description = "Versão da engine do banco"
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC"
}

variable "db_subnet_group_name" {
  type        = string
  description = "ID do Subnet Group que será utilizado pela instância"
}

variable "security_group_ids" {
  type        = set(string)
  default     = null
  description = "Segurity group para Base."
}

variable "inbound_rules" {
  type = list(object({
    description = string,
    cidr_blocks = list(string)
  }))
  default     = []
  description = "Lista de regras de entrada para liberação de IPs."
}

variable "parameter_group_family" {
  type        = string
  default     = ""
  description = "Família do grupo de parâmetros do banco de dados."
}

variable "db_parameters" {
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  description = "Lista de parâmetros a serem configurados no parameter group."
  validation {
    condition     = alltrue([for i in var.db_parameters : contains(["immediate", "pending-reboot"], i.apply_method)])
    error_message = "Valor inválido de apply_method. Valores válidos: immediate e pending-reboot."
  }
  default = []
}

variable "db_options" {
  type = map(object({
    port = number
    option_settings = list(object({
      name  = string
      value = string
    }))
  }))
  description = "Lista de parâmetros a serem configurados no parameter group."
  default     = {}
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Quando essa opção é habilitada para `true`, todas as mudanças no RDS ocorrem **imediatamente** . Caso fique desabilitada, as mudanças solicitadas ocorrerão na próxima janela de manutenção (Recomendado para ambiente de PRD)."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Executar em MultiAZ."
}

variable "instance_class" {
  type        = string
  description = "Tipo de Instancia."
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "Tipo de Disco."
  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2"], var.storage_type)
    error_message = "Tipo de disco invalido. Valores aceitos: gp2, gp3, io1, io2."
  }
}

variable "storage_throughput" {
  type        = number
  default     = null
  description = "Quantidade de MiB provisionados. Valores aceitos: SQLServer (125–1000 MiB/s) - Demais (500–4000 MiB/s)"
  validation {
    condition     = var.storage_throughput == null ? true : (var.storage_throughput >= "125" && var.storage_throughput <= "4000")
    error_message = "Tipo de storage_throughput inválido. Valores aceitos: SQLServer (125–1000 MiB/s) - Demais (500–4000 MiB/s). ref.: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html."
  }
}

variable "iops" {
  type        = number
  default     = null
  description = "Quantidade de IOPS provisionados. Valores aceitos: SQLServer (3000–16000 IOPS) - Demais (12000–64000 IOPS)"
  validation {
    condition     = var.iops == null ? true : (var.iops >= "3000" && var.iops <= "64000")
    error_message = "Quantidade de IOPS inválido. Valores aceitos: SQLServer (3000–16000 IOPS) - Demais (12000–64000 IOPS). ref.: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html."
  }
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Alocação de storage para a instância do banco"
}

variable "max_allocated_storage" {
  type        = number
  default     = null
  description = "Tamanho máximo de alocação de storage para a instância do banco"
}

variable "username" {
  type        = string
  description = "Username do Root da Base."
}

variable "password" {
  type        = string
  sensitive   = true
  description = "Senha do Root da Base"
}

variable "deletion_protection" {
  type        = string
  default     = false
  description = "Se verdadeiro, necessita desabilitar no console a proteção contra exclusão acidental."
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "Período de retenção do backup via snapshot."
}

variable "copy_tags_to_snapshot" {
  type        = bool
  default     = true
  description = "Se copiará as tags para os snapshots ou não."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Se verdadeiro, não necessita de snapshot final para destruir o banco de dados."
}

variable "backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "Janela de backup via snapshot."
}

variable "maintenance_window" {
  type        = string
  default     = "sun:04:00-sun:04:30"
  description = "Janela de manutenção para implementação de atualizações, por exemplo."
}

variable "monitoring_interval" {
  type        = number
  default     = 30
  description = "Intervalo do recurso enhanced monitoring."
}

variable "performance_insights_enabled" {
  type        = bool
  default     = true
  description = "Indica se performance insights será ativado ou não. Atenção para o suporte desse recurso no MySQL: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights.Overview.Engines.html"
}

variable "performance_insights_retention_period" {
  type        = number
  default     = 7
  description = "Período de retenção dos dados do Performance Insights."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}

variable "logging_retention" {
  type        = number
  default     = 14
  description = "Tempo em dias para retenção de logs no CloudWatch."
}

variable "availability_time" {
  type    = string
  default = "24/7"
  validation {
    condition     = contains(["12/5", "12/7", "18/5", "18/7", "24/5", "24/7"], var.availability_time)
    error_message = "Períodos de disponibilidade válidos: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`."
  }
  description = "Período de disponibilidade do serviço: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`."
}

variable "s3_role" {
  type        = string
  default     = null
  description = "Role com acesso ao Bucket S3 que será usado para backup/restore instâncias SQL Server"
}

variable "s3_policy_arn" {
  type        = string
  default     = null
  description = "Policy que será atribuída à role do RDS SQL Server. Obrigatório caso seja criado um RDS SQL Server."
}