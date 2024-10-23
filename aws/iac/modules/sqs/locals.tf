locals {
  name_suffix     = var.fifo ? ".fifo" : ""
  queue_name      = "sqs-${module.this.custom_context_id}-${var.name}${local.name_suffix}"
  dlq_name        = "sqs-${module.this.custom_context_id}-${var.name}-dlq${local.name_suffix}"
  app_policy_name = "policy-app-sqs-${module.this.custom_context_id}-${var.name}"
}