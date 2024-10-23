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
  description = "Nome do Website."
}

variable "aliases" {
  type        = list(string)
  description = "Listas de aliases do Website."
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Classe de preço do Website. Possíveis valores: PriceClass_All, PriceClass_200, PriceClass_100"
}

variable "default_root_file" {
  type        = string
  default     = "index.html"
  description = "Arquivo raiz padrão do Website."
}

variable "custom_error_pages" {
  type        = map(any)
  default     = {}
  description = "Páginas de erro customizadas do Website. Ex.: `404 = \"/index.html\"`."
}

variable "custom_error_response" {
  type        = list(any)
  default     = null
  description = "Páginas de erro customizadas do Website e seus respectivos return codes."
}

variable "error_caching_min_ttl" {
  type        = number
  default     = 300
  description = "TTL em segundos para caching das páginas de erro do Website."
}

variable "waf_acl_arn" {
  type        = string
  default     = null
  description = "ARN da ACL do WAF para ser utilizada no Website."
}

variable "enable_access_logs" {
  type        = bool
  default     = false
  description = "Indica se o website terá logs de acesso armazenados em um bucket S3."
}

variable "include_cookies_for_access_logs" {
  type        = bool
  default     = false
  description = "Indica se deve incluir os cookies nos logs de acesso armazenados."
}

variable "certificate_arn" {
  type        = string
  description = "ARN do certificado do ACM para ser utilizado pelo Website."
}

variable "minimum_protocol_version" {
  type        = string
  default     = "TLSv1.2_2021"
  description = "Versão mínima do protocolo de SSL que será suportada pelo Website: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html."
}

variable "allowed_methods" {
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "Lista de métodos permitidos no cache behavior default. Ex: GET, HEAD, OPTIONS"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "Lista de métodos permitidos de cache no cache behavior default. Ex: GET, HEAD "
}

variable "compress" {
  type        = bool
  default     = true
  description = "Determina se os arquivos serão comprimidos em formato gzip"
}

variable "default_ttl" {
  type        = number
  default     = 3600
  description = "TTL em segundos padrão para caching das páginas do Website."
}

variable "min_ttl" {
  type        = number
  default     = 300
  description = "TTL em segundos mínimo para caching das páginas do Website."
}

variable "max_ttl" {
  type        = number
  default     = 86400
  description = "TTL em segundos padrão para caching das páginas do Website."
}

variable "response_headers_policy_id" {
  type        = string
  default     = null
  description = "Id da response header policy que será utilizada no Default Cache Beheavior"
}

variable "cache_policy_id" {
  type        = string
  default     = null
  description = "Id da cache policy que será utilizada no Default Cache Beheavior"
}

variable "function_association" {
  type        = map(any)
  default     = {}
  description = "Associações de funções CloudFront para o Cache Behaviour."
}

variable "lambda_function_association" {
  type        = map(any)
  default     = {}
  description = "Associações de funções Lambda@Edge para o Cache Behaviour."
}

variable "create_cicd_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para CI/CD."
}

variable "create_bucket_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações no buckets."
}

variable "use_forwarded_values" {
  type        = bool
  default     = true
  description = "Indica se deve usar o fowarded values no default cache behavior."
}

variable "origin_custom_headers" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "Cloudfront incluirá esses headers em todas as requisições que enviará para sua origin"
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Indica se é para incluir todos query strings na chave do cache."
}

variable "bucket_cors_rules" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default     = []
  description = "Regras de cors que serão aplicadas no bucket criado."
}

variable "ordered_cache_behavior" {
  type        = list(any)
  default     = []
  description = "Regras de cache behavior para serem utilizadas além da padrão."
}

variable "bucket_expiration_rules" {
  type = list(object({
    prefix : string,
    days : number
  }))
  default     = []
  description = "Regras de expiração de objetos do bucket."
}

