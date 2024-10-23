variable "tags" {
  type = map(string)
  default = {
    map-migrated = "d-server-01oiau1h5afqhv",
    Environment  = "shared",
    IAC          = true
  }
  description = "Tags obrigatórias para todos os recursos."
}

variable "public_subnets_use1_tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todas as subnets públicas de USE1"
}

variable "private_subnets_use1_tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todas as subnets privadas de USE1"
}

variable "public_subnets_sae1_tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todas as subnets públicas de SAE1"
}

variable "private_subnets_sae1_tags" {
  type        = map(string)
  default     = {}
  description = "Tags para todas as subnets privadas de SAE1"
}

variable "aws_ad_ip" {
  type        = string
  description = "IP do AD na shared-services"
  default     = "10.92.22.187"
}

variable "on_premisses_ad_ip" {
  type        = string
  description = "IP do AD on-premisses"
  default     = "10.150.200.20"
}

variable "rtm_dns1_ip" {
  type        = string
  description = "IP do DNS1"
  default     = "10.0.33.2"
}

variable "rtm_dns2_ip" {
  type        = string
  description = "IP do DNS2"
  default     = "10.0.17.2"
}

variable "private_certificate_domains" {
  type        = list(any)
  description = "Lista de domínios para certificado privado ACM."
  default     = ["*.anbima.cloud", "dev.anbima.cloud", "*.dev.anbima.cloud", "hml.anbima.cloud", "*.hml.anbima.cloud", "cer.anbima.cloud", "*.cer.anbima.cloud", "prd.anbima.cloud", "*.prd.anbima.cloud"]
}

variable "public_certificate_domains" {
  type        = list(any)
  description = "Lista de domínios para certificado público ACM."
  default     = ["*.anbima.com.br", "dev.anbima.com.br", "*.dev.anbima.com.br", "hml.anbima.com.br", "*.hml.anbima.com.br", "cer.anbima.com.br", "*.cer.anbima.com.br", "prd.anbima.com.br", "*.prd.anbima.com.br"]
}
