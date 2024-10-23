locals {
  cluster_name       = "rds-cluster-${module.this.custom_context_id}-${var.name}"
  instance_base_name = "rds-instance-${module.this.custom_context_id}-${var.name}"
  sg_name            = "SG-rds-${module.this.custom_context_id}-${var.name}"
  role_name          = "role-rds-${module.this.custom_context_id}-${var.name}"
  cluster_pg_name    = "rds-cluster-pg-${module.this.custom_context_id}-${var.name}"
  db_pg_name         = "rds-db-pg-${module.this.custom_context_id}-${var.name}"
  log_group_name     = "/aws/rds/cluster/${local.cluster_name}/${var.type}"
  db_params = {
    mysql = {
      engine                          = "aurora-mysql"
      port                            = 3306
      enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
    }
    postgresql = {
      engine                          = "aurora-postgresql"
      port                            = 5432
      enabled_cloudwatch_logs_exports = ["postgresql"]
    }
  }
  pl_ids = var.region == "us-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id] : var.region == "sa-east-1" ? [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id] : []
}