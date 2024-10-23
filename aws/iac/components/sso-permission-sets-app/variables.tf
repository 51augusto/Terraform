variable "sso_applications" {
  type = map(object({
    application_tag_key    = string
    application_tag_values = list(string)
    component_name         = string
  }))

  default     = {}
  description = <<EOF
  Map de aplicações para serem configurados os grupos (GR_AWS_<APLICACAO>_RO , GR_AWS_<APLICACAO>_DEV , GR_AWS_<APLICACAO>_OWNER) e Permissions Sets do SSO. A chave de cada map é a identificação da aplicação no nome dos grupos. Exemplo:

  sso_applications =  {
    FEED = {
      application_tag_key    = "Application"
      application_tag_values = ["Feed"]
      component_name         = "feed"
    },
    FUNDOS = {
      application_tag_key    = "Application"
      application_tag_values = ["Site Fundos","Windows Shared"]
      component_name         = "site-fundos"
    }
  }
  EOF

  validation {
    condition     = !contains([for k, v in var.sso_applications : false if !contains(["Application", "BusinessArea"], v.application_tag_key)], false)
    error_message = "Valor para atributo application_tag_key inválido. Validar cada map de aplicação. Valores válidos: Application e BusinessArea ."
  }
}