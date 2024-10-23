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
  description = "Nome do RDS."
}

variable "engine_version" {
  type        = string
  description = "Versao do banco de dados."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC do banco de dados."
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nome do Subnet Group do banco de dados."
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

variable "db_cluster_parameter_group_name" {
  type        = string
  default     = ""
  description = "Nome do Cluster Parameter Group a ser associado ao cluster. Se indefinido, cria um padrão com a familia definida em `parameter_group_family`."
}

variable "cluster_instances" {
  type        = number
  default     = 1
  description = "Quantidade de servidores no cluster."
}

variable "instance_class" {
  type        = string
  default     = "db.t4g.medium"
  description = "Tamanho da instancia de banco de dados."
}

variable "master_username" {
  type        = string
  sensitive   = true
  default     = "dbadmin"
  description = "Nome de usuario master do banco de dados."
}

variable "master_password" {
  type        = string
  sensitive   = true
  description = "Senha do banco de dados."
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

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Se verdadeiro, não necessita de snapshot final para destruir o banco de dados."
}

variable "preferred_backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "Janela de backup via snapshot."
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:04:00-sun:04:30"
  description = "Janela de manutenção para implementação de atualizações, por exemplo."
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