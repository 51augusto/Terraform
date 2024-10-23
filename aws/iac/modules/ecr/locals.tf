locals {
  ecr_name         = "ecr-${module.this.custom_context_id}/${var.name}"
  pull_policy_name = "policy-pull-ecr-${module.this.custom_context_id}-${var.name}"
}