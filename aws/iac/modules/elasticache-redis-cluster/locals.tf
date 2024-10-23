locals {
  sg_name = "SG-elasticache-${module.this.custom_context_id}-${var.name}"
  pg_name = "elasticache-pg-${module.this.custom_context_id}-${var.name}"
  name    = "elasticache-${module.this.custom_context_id}-${var.name}"

  pl_ids_sae1 = [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id, data.terraform_remote_state.network.outputs.anbima_dc_cidrs_pl_sae1_id]
  pl_ids_use1 = [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id, data.terraform_remote_state.network.outputs.anbima_dc_cidrs_pl_use1_id]
  pl_ids      = var.region == "us-east-1" ? local.pl_ids_use1 : var.region == "sa-east-1" ? local.pl_ids_sae1 : []
}