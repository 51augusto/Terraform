locals {
  authorizer_name = "api-auth-${module.this.custom_context_id}-${var.name}"
  user_pool_name  = "user-pool-${local.authorizer_name}"
}