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
  description = "Nome do Cluster Redshift."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC do cluster."
}

variable "cluster_subnet_group_name" {
  type        = string
  description = "Nome do Subnet Group do cluster."
}

variable "inbound_rules" {
  type = list(object({
    description = string,
    cidr_blocks = list(string)
  }))
  default     = []
  description = "Lista de regras de entrada para liberação de IPs."
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "Zona de disponibilidade para provisionamento do cluster."
}

variable "enhanced_vpc_routing" {
  type        = bool
  default     = false
  description = "Ativa recursos de roteamento aprimorado da VPC."
}

variable "parameter_group_family" {
  type        = string
  default     = ""
  description = "Família do grupo de parâmetros do cluster."
}

variable "parameter_group_name" {
  type        = string
  default     = ""
  description = "Nome do Cluster Parameter Group a ser associado ao cluster. Se indefinido, cria um padrão com a familia definida em `parameter_group_family`."
}

variable "database_name" {
  type        = string
  default     = "dev"
  description = "Nome da primeira database criada quando o cluster é criado"
}

variable "cluster_version" {
  type        = string
  description = "Versão do cluster"
}

variable "node_type" {
  type        = string
  default     = "dc2.large"
  description = "Tipo do nó que compõe o cluster"
}

variable "cluster_type" {
  type        = string
  description = "Tipo do cluster"
  validation {
    condition     = contains(["single-node", "multi-node"], var.cluster_type)
    error_message = "Valor errado para 'cluster_type'. Valores validos single-node e multi-node."
  }
}

variable "number_of_nodes" {
  type        = number
  default     = 1
  description = "Número de nós que compõe o cluster"
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

variable "automated_snapshot_retention_period" {
  type        = number
  default     = 7
  description = "Período de retenção do backup automático via snapshot."
}

variable "allow_version_upgrade" {
  type        = bool
  default     = false
  description = "Permitir upgrade automático de versão Major do cluster."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "Se verdadeiro, não necessita de snapshot final para destruir o banco de dados."
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "sun:04:00-sun:04:30"
  description = "Janela de manutenção para implementação de atualizações, por exemplo."
}

variable "iam_roles" {
  type        = list(string)
  default     = []
  description = "Roles a serem associadas ao cluster."
}

variable "logging" {
  type = object({
    enable        = bool
    bucket_name   = string
    s3_key_prefix = string
  })
  default = {
    enable        = false
    bucket_name   = ""
    s3_key_prefix = ""
  }
  description = "Configuração de logging do cluster."
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}