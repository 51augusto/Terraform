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
  description = "Nome da instância."
}

variable "os" {
  type        = string
  default     = "linux"
  description = "Sistema operacional. Valores permitidos: `linux` e `windows`. Utilizado para popular a Tag `OS` da instância"
  validation {
    condition     = contains(["linux", "windows"], var.os)
    error_message = "Valor para os inválido. Valores válidos: linux e windows."
  }
}

variable "hostname" {
  type        = string
  default     = null
  description = "Valor do hostname para máquinas Windows, ignorado para máquinas Linux. Popula a Tag `Hostname` da instância, que é utilizada pós inicialização, para definição do hostname localmente e na OU do Active Directory."

  # Ativar quando validação entre variáveis for implementada: https://github.com/hashicorp/terraform/issues/25609
  # validation {
  #   condition     = var.os == "linux" || (var.os == "windows" && var.hostname != null && trimspace(var.hostname) != "")
  #   error_message = "A variável hostname é obrigatória para instâncias windows."
  # }
}

variable "ami" {
  type        = string
  description = "ID da AMI da instância."
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Tipo da instância."
}

variable "subnet" {
  type        = string
  description = "ID da subnet da instância."
}

variable "role" {
  type        = string
  default     = null
  description = "Nome da Role a ser associada à instância. Se indefinido, uma nova será criada."
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "Identificadores dos Security Groups a serem associados à instância. Se indefinido, um novo será criado."
}

variable "user_data" {
  type        = string
  default     = null
  description = "User Data da instância. Se indefinido utiliza o padrão de cada OS."
}

variable "user_data_append" {
  type        = string
  default     = null
  description = "Conteúdo extra a ser adicionado ao fim do User Data padrão da instância."
}

variable "public_ip" {
  type        = bool
  default     = false
  description = "Habilita IP público para a instância"
}

variable "source_dest_check" {
  type        = bool
  default     = true
  description = "Controla se o tráfego é roteado para as instâncias quando o endereço de destino não encontra a instância. Usado para NAT, VPNs ou Firewalls. "
}

variable "private_ip" {
  type        = string
  default     = null
  description = "Configura um IP privado específico para a instância"
}

variable "ebs_optimized" {
  type        = bool
  default     = true
  description = "Habilita otimização de EBS."
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "Habilita monitoração detalhada."
}

variable "prometheus_exporter" {
  type        = bool
  default     = true
  description = "Habilita a instalação do Prometheus Exporter"
}

variable "dr_backup" {
  type        = bool
  default     = false
  description = "Habilita o DR Backup"
}

variable "availability_time" {
  type    = string
  default = "24/7"
  validation {
    condition     = contains(["12/5", "12/7", "18/5", "18/7", "24/5", "24/7", "poweroff"], var.availability_time)
    error_message = "Períodos de disponibilidade válidos: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`, `poweroff`."
  }
  description = "Período de disponibilidade da instância: `12/5`, `12/7`, `18/5`, `18/7`, `24/5`, `24/7`, `poweroff`."
}


variable "termination_protection" {
  type        = bool
  default     = false
  description = "Habilita proteção contra termination da instância."
}

variable "enable_metadata_tags" {
  type        = bool
  default     = true
  description = "Habilita acesso às tags no metadata da instância."
}

variable "root_ebs" {
  type = object({
    size : string,
    type : string,
    encrypted : bool,
    delete_on_termination : bool
  })
  default = {
    size                  = "40"
    type                  = "gp3"
    encrypted             = true
    delete_on_termination = true
  }
  description = "Especificação do EBS raiz da instãncia."
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "ARNs de políticas a serem anexadas à Role padrão da instância. Ignorado se uma role for definida."
}

variable "tags" {
  type = object({
    Role : string
    Version : string
  })
  description = "Tags obrigatórias."
}

variable "extra_tags" {
  type        = map(any)
  default     = {}
  description = "Tags extras livres."
}

variable "allow_rdp" {
  type        = bool
  default     = false
  description = "Habilita a criação de regras de acesso ao RDP"
}

variable "rdp_sg_anbima_pl" {
  type        = list(any)
  default     = null
  description = "Prefix lists a serem adicionados na regra de RDP"
}
