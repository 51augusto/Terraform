variable "app" {
  type        = string
  description = "Nome da aplicação."
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

variable "ec2_polices_arns" {
  type        = list(string)
  default     = null
  description = "Lista de ARNs das policies para uma Role a ser utilizada em uma EC2."
}

variable "cicd_polices_arns" {
  type        = list(string)
  default     = []
  description = "Lista de ARNs das policies para uma Role a ser utilizada em jobs de CI/CD."
}

variable "cicd_max_session_duration" {
  type        = number
  default     = 3600
  description = "Tempo máximo de duração de sessão da Role de CI/CD em segundos."
}

variable "eks_applications" {
  type = map(object({
    app_name          = string
    eks_policies_arns = list(string)
  }))

  default     = {}
  description = <<EOF
  Map de aplicações para serem criadas Roles que serão utilizadas no EKS. Exemplo:

  eks_applications = {
    app-1 = {
    app_name = "backend"
    eks_policies_arns = []
    },
    app-2 = {
    app_name = "api-main"
    eks_policies_arns = []
    }
  }
  EOF
}

variable "eks_polices_arns" {
  type        = list(string)
  default     = null
  description = "Lista de ARNs das policies para uma Role a ser utilizada no EKS. Para Roles específicas por aplicação, utilizar `eks_applications`."
}

variable "ecs_applications" {
  type = map(object({
    app_name          = string
    ecs_policies_arns = list(string)
  }))

  default     = {}
  description = <<EOF
  Map de aplicações para serem criadas Roles que serão utilizadas no ECS. Exemplo:

  ecs_applications = {
    app-1 = {
    app_name = "backend"
    ecs_policies_arns = []
    },
    app-2 = {
    app_name = "api-main"
    ecs_policies_arns = []
    }
  }
  EOF
}

variable "ops_policies_arns" {
  type        = list(string)
  default     = []
  description = "Lista de ARNs das policies para uma Role a ser utilizada em jobs de Ferramentas de Operações."
}

variable "ops_max_session_duration" {
  type        = number
  default     = 3600
  description = "Tempo máximo de duração de sessão da Role de Operações em segundos."
}