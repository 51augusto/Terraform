locals {
  cluster_name        = "docdb-cluster-${module.this.custom_context_id}-${var.name}"
  instance_base_name  = "docdb-instance-${module.this.custom_context_id}-${var.name}"
  sg_name             = "SG-docdb-${module.this.custom_context_id}-${var.name}"
  create_cluster_pg   = var.db_cluster_parameter_group_name == ""
  cluster_pg_name     = local.create_cluster_pg ? "docdb-cluster-pg-${module.this.custom_context_id}-${var.name}" : var.db_cluster_parameter_group_name
  log_group_base_name = "/aws/docdb/${local.cluster_name}"
  pl_ids              = var.region == "us-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id] : var.region == "sa-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id] : []
}