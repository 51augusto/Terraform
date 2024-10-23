variable "area" {
  type        = string
  description = "Área Owner da aplicação. Ex.: corp, rh, operacoes."
}

variable "app" {
  type        = string
  description = "Nome da aplicação."
}

variable "environment" {
  type        = string
  description = "Identificador do ambiente."
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN do OIDC Provider do cluster."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Região AWS."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels a serem aplicadas aos recursos."
}

variable "quota" {
  type = any
  default = {
    cpu = {
      limit   = "2"
      request = "1"
    }
    memory = {
      limit   = "2Gi"
      request = "1Gi"
    }
    storage = "0"
  }
  description = "Cota de recursos totais do namespace."
}

variable "container_default_resources" {
  type = any
  default = {
    cpu = {
      limit   = "1"
      request = "200m"
    }
    memory = {
      limit   = "512Mi"
      request = "128Mi"
    }
  }
  description = "Definição padrão de recursos dos containers."
}

variable "cicd_permission_rules" {
  type = list(object({
    api_groups = list(string)
    verbs      = list(string)
    resources  = list(string)
  }))
  default = [{
    api_groups = ["", "apps", "batch", "extensions", "autoscaling", "networking.k8s.io", "secrets-store.csi.x-k8s.io", "monitoring.coreos.com", "keda.sh"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
    resources  = ["configmaps", "cronjobs", "deployments", "deployments/scale", "events", "ingresses", "jobs", "pods", "pods/attach", "pods/exec", "pods/log", "pods/portforward", "secrets", "services", "persistentvolumeclaims", "horizontalpodautoscalers", "secretproviderclasses", "prometheusrules", "podmonitors", "servicemonitors", "probes", "scaledjobs", "scaledobjects", "triggerauthentications"]
    }
  ]
  description = "Regras de permissionamento para a Service Account de CI/CD."
}

variable "ops_permission_rules" {
  type = list(object({
    api_groups = list(string)
    verbs      = list(string)
    resources  = list(string)
  }))
  default = [{
    api_groups = ["", "apps", "batch", "extensions", "secrets-store.csi.x-k8s.io"]
    verbs      = ["create", "delete", "get", "list", "patch", "update", "watch"]
    resources  = ["events", "jobs", "pods", "pods/attach", "pods/exec", "pods/log", "pods/portforward", "secretproviderclasses"]
    },
    {
      api_groups = [""]
      verbs      = ["get", "patch"]
      resources  = ["namespaces"]
    }
  ]
  description = "Regras de permissionamento para a Service Account de Operações."
}

variable "app_permission_rules" {
  type = list(object({
    api_groups = list(string)
    verbs      = list(string)
    resources  = list(string)
  }))
  default     = null
  description = "Regras de permissionamento para a Service Account da aplicação."
}

variable "app_secrets_arns" {
  type        = list(string)
  default     = null
  description = "ARNs dos secrets que devem ser acessíveis pela aplicação."
}