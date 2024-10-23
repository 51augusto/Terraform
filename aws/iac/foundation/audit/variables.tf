variable "tags" {
  type = map(string)
  default = {
    map-migrated = "d-server-01oiau1h5afqhv",
    Environment  = "audit",
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