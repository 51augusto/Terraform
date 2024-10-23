variable "tags" {
  type = map(string)
  default = {
    map-migrated = "d-server-01oiau1h5afqhv",
    Environment  = "hml",
    IAC          = true
  }
  description = "Tags obrigatórias para todos os recursos."
}

variable "public_subnets_use1_tags" {
  type        = map(string)
  description = "Tags para todas as subnets públicas de USE1"
}

variable "private_subnets_use1_tags" {
  type        = map(string)
  description = "Tags para todas as subnets privadas de USE1"
}

variable "public_subnets_sae1_tags" {
  type        = map(string)
  description = "Tags para todas as subnets públicas de SAE1"
}

variable "private_subnets_sae1_tags" {
  type        = map(string)
  description = "Tags para todas as subnets privadas de SAE1"
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