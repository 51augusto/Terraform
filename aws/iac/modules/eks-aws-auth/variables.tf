variable "region" {
  type        = string
  description = "Região AWS"
}

variable "app_names_for_k8s_users" {
  type        = list(string)
  description = "Lista de nomes das aplicações baseado no nome do permissions sets SSO. O nome do permission sets tem o padrão de nome: $APLICACAO_RO ou $APLICACAO_EDITOR. Passar o valor de $APLICACAO. Essa variável está sendo utilizada para criar um usuário no Kubernetes via ConfigMap `aws-auth`"
}

variable "app_names_for_k8s_cicd" {
  type        = list(string)
  description = "Lista de nomes das aplicações baseado no `component_name` que será preenchido no Terraform. Essa variável está sendo utilizada para criar um usuário de CI/CD no Kubernetes via ConfigMap `aws-auth`"
}

variable "app_names_for_k8s_ops" {
  type        = list(string)
  description = "Lista de nomes das aplicações baseado no `component_name` que será preenchido no Terraform. Essa variável está sendo utilizada para criar um usuário de Operações no Kubernetes via ConfigMap `aws-auth`"
}

variable "extra_auths" {
  type = list(object({
    rolearn  = string
    username = string
  }))
  default     = []
  description = "Mapeamentos de autorização extras que serão aplicados junto aos automáticos."
}

variable "extra_sso_auths" {
  type = list(object({
    permission_set_name = string
    username            = string
  }))
  default     = []
  description = "Mapeamentos de autorização extras do SSO que serão aplicados."
}

variable "environment" {
  type        = string
  description = "Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` "

  validation {
    condition     = contains(["dev", "cer", "hml", "prd", "shared", "sandbox"], var.environment)
    error_message = "Valor para environmet inválido. Valores válidos: dev, cer, hml, prd, shared, sandbox ."
  }
}