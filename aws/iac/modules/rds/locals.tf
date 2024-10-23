locals {
  instance_name     = "rds-instance-${module.this.custom_context_id}-${var.name}"
  sg_name           = "SG-ec2-${module.this.custom_context_id}-${var.name}-db"
  role_name         = "role-rds-${module.this.custom_context_id}-${var.name}"
  log_group_name    = "/aws/rds/instance/${local.instance_name}"
  s3_role_name      = local.is_mssql ? "role-rds-s3-${module.this.custom_context_id}-${var.name}" : null
  db_pg_name        = "rds-db-pg-${module.this.custom_context_id}-${var.name}"
  db_opt_grp        = "rds-db-optgrp-${module.this.custom_context_id}-${var.name}"
  db_opt_grp_config = local.is_mssql ? aws_db_option_group.sqlserver_option_group[0].id : local.is_mysql ? aws_db_option_group.mysql_option_group[0].id : ""
  is_mssql          = length(regexall("mssql+", var.type)) > 0
  is_mysql          = contains(["mysql"], var.type)

  db_params = {
    mysql = {
      engine                          = "mysql"
      port                            = 3306
      enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
    }
    postgresql = {
      engine                          = "postgres"
      port                            = 5432
      enabled_cloudwatch_logs_exports = ["postgresql"]
    }
    mssql-se = {
      engine                          = "sqlserver-se"
      port                            = 1433
      enabled_cloudwatch_logs_exports = ["agent", "error"]
    }
    mssql-ex = {
      engine                          = "sqlserver-ex"
      port                            = 1433
      enabled_cloudwatch_logs_exports = ["error"]
    }
    mssql-web = {
      engine                          = "sqlserver-web"
      port                            = 1433
      enabled_cloudwatch_logs_exports = ["agent", "error"]
    }
  }
  pl_ids_sae1 = [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id, data.terraform_remote_state.network.outputs.anbima_dc_cidrs_pl_sae1_id]
  pl_ids_use1 = [data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id, data.terraform_remote_state.network.outputs.anbima_dc_cidrs_pl_use1_id]

  pl_ids = var.region == "us-east-1" ? local.pl_ids_use1 : var.region == "sa-east-1" ? local.pl_ids_sae1 : []
}
