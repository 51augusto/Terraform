locals {
  name = "dynamodb-${module.this.custom_context_id}-${var.name}"
  attributes = concat(
    [var.hash_key],
    var.range_key != null ? [var.range_key] : [],
    var.attributes
  )
  app_policy_name = "policy-app-dynamodb-${module.this.custom_context_id}-${var.name}"
  tags = merge(
    {
      Name   = local.name
      Backup = var.dr_backup
    }
  )

}