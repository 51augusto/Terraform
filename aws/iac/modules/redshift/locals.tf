locals {
  cluster_name      = "redshift-cluster-${module.this.custom_context_id}-${var.name}"
  sg_name           = "SG-redshift-${module.this.custom_context_id}-${var.name}"
  create_cluster_pg = var.parameter_group_name == ""
  cluster_pg_name   = local.create_cluster_pg ? "redshift-cluster-pg-${module.this.custom_context_id}-${var.name}" : var.parameter_group_name
  pl_ids            = var.region == "us-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id] : var.region == "sa-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id] : []
}