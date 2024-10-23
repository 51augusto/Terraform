locals {
  api_name       = "api-${module.this.custom_context_id}-${var.name}"
  domain_name    = "api-domain-${module.this.custom_context_id}-${var.name}"
  api_stage_name = "api-stage-${module.this.custom_context_id}-${var.name}"
  log_group_name = "/aws/apigateway/${local.api_name}"
}