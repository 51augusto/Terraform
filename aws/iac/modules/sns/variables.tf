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
  description = "Nome do tópico SNS."
}

variable "fifo" {
  type        = bool
  default     = false
  description = "Define se o tópico é FIFO"
}

variable "content_based_deduplication" {
  type        = bool
  default     = false
  description = <<EOF
  Habilta o content-based deduplication para quando o tópico for FIFO. 
  
  Ref: https://docs.aws.amazon.com/sns/latest/dg/fifo-message-dedup.html
  EOF
}

variable "kms_key" {
  type        = string
  default     = null
  description = "ID/alias de chave KMS customizada. Caso não seja passado um valor, é utilizada a chave KMS padrão da AWS"
}

variable "create_app_policy" {
  type        = bool
  default     = false
  description = "Indica se deve criar a política de acesso para aplicações."
}

variable "delivery_policy" {
  type        = map(any)
  default     = null
  description = "Política de entrega do tópico customizada. Se não atribuída, é configurada uma política default."
}

variable "topic_policy" {
  type        = list(any)
  default     = []
  description = <<EOF
  Statements adicionais para a política de acesso do tópico. Se não atribuída, é configurada uma política default.

  topic_policy = [
    {
        Sid    = "SnsStatement"
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::<ACCOUNT_ID>:role/role-sns-publisher"
        },
        Action = [
          "SNS:Subscribe",
          "SNS:SetTopicAttributes",
          "SNS:RemovePermission",
          "SNS:Receive",
          "SNS:Publish",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:AddPermission"
        ]

        Resource = ["arn:aws:sns:us-east-1:<ACCOUNT_ID>:sns-topic"]
      }
  ]
  EOF

}