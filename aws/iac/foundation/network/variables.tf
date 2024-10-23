variable "tags" {
  type = map(string)
  default = {
    map-migrated = "d-server-01oiau1h5afqhv",
    Environment  = "network",
    IAC          = true
  }
  description = "Tags obrigatórias para todos os recursos."
}

variable "resources" {
  type        = map(object({ component_name = string, resource_id = string, environment = string }))
  default     = {}
  description = "Map de objetos para gerar naming convention."
}

variable "tgw_attachments_sae1" {
  type        = map(object({ tgw_attachment_id = string, cidr_block = string, name = string, suffix = string, on_prem = bool }))
  default     = {}
  description = "Lista de TGW attachments de todas as VPCs de SAE1"
}

variable "tgw_attachments_use1" {
  type        = map(object({ tgw_attachment_id = string, cidr_block = string, name = string, suffix = string, on_prem = bool }))
  default     = {}
  description = "Lista de TGW attachments de todas as VPCs de USE1"
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