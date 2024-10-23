variable "private_zone_vpc_ids" {
  type        = map(any)
  default     = {}
  description = "ID da VPC da Zona Privada. "
}

variable "private_zone" {
  type        = bool
  default     = false
  description = "Determina se uma zona privada será criada."
}

variable "public_zone" {
  type        = bool
  default     = false
  description = "Determina se uma zona pública será criada"
}

variable "private_sub_domain_name" {
  type        = string
  default     = ""
  description = "Nome do sub-domínio da zona privada. Quando **private_zone** for true, essa variável deve ser fornecida."
}

variable "public_sub_domain_name" {
  type        = string
  default     = ""
  description = "Nome do sub-domínio da zona pública. Quando **public_zone** for true, essa variável deve ser fornecida."
}

variable "private_domain_name" {
  type        = string
  default     = "anbima.cloud"
  description = "Nome do domínio da zona privada. Quando **private_zone** for true, essa variável deve ser fornecida."
}

variable "public_domain_name" {
  type        = string
  default     = "anbima.com.br"
  description = "Nome do domínio da zona pública. Quando **public_zone** for true, essa variável deve ser fornecida."
}
