resource "aws_db_parameter_group" "db_pg" {
  name        = local.db_pg_name
  family      = var.parameter_group_family
  description = "DB Parameter Group de ${local.instance_name}"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = {
    Name = local.db_pg_name
  }
}

resource "aws_db_option_group" "sqlserver_option_group" {
  count                    = local.is_mssql ? 1 : 0
  name                     = local.db_opt_grp
  option_group_description = "DB Option group da instância RDS ${local.instance_name}"
  engine_name              = local.db_params[var.type].engine
  major_engine_version     = regex("[0-9]{2}.[0-9]{2}", var.engine_version)

  option {
    option_name                    = "SQLSERVER_BACKUP_RESTORE"
    vpc_security_group_memberships = []

    option_settings {
      name  = "IAM_ROLE_ARN"
      value = var.s3_role == null ? aws_iam_role.s3_role[0].arn : var.s3_role
    }
  }

  dynamic "option" {
    for_each = var.db_options
    content {
      option_name                    = upper(option.key)
      vpc_security_group_memberships = var.security_group_ids == null ? [aws_security_group.sg[0].id] : var.security_group_ids
      port                           = option.value.port

      dynamic "option_settings" {
        for_each = option.value.option_settings
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }


  tags = {
    Name = local.db_opt_grp
  }
}

resource "aws_db_option_group" "mysql_option_group" {
  count                    = local.is_mysql ? 1 : 0
  name                     = local.db_opt_grp
  option_group_description = "DB Option group da instância RDS ${local.instance_name}"
  engine_name              = local.db_params[var.type].engine
  major_engine_version     = regex("[0-9]{1,2}.[0-9]{1,2}", var.engine_version)

  dynamic "option" {
    for_each = var.db_options
    content {
      option_name                    = upper(option.key)
      vpc_security_group_memberships = var.security_group_ids == null ? [aws_security_group.sg[0].id] : var.security_group_ids
      port                           = option.value.port

      dynamic "option_settings" {
        for_each = option.value.option_settings
        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  tags = {
    Name = local.db_opt_grp
  }
}

resource "aws_cloudwatch_log_group" "rds_logs" {
  for_each          = toset(local.db_params[var.type].enabled_cloudwatch_logs_exports)
  name              = "${local.log_group_name}/${each.key}"
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_name
  }
}

resource "aws_db_instance" "db_instance" {
  identifier                            = local.instance_name
  engine                                = local.db_params[var.type].engine
  engine_version                        = var.engine_version
  port                                  = local.db_params[var.type].port
  parameter_group_name                  = aws_db_parameter_group.db_pg.id
  option_group_name                     = local.db_opt_grp_config
  vpc_security_group_ids                = var.security_group_ids == null ? [aws_security_group.sg[0].id] : var.security_group_ids
  db_subnet_group_name                  = var.db_subnet_group_name
  username                              = var.username
  password                              = var.password
  storage_encrypted                     = true
  enabled_cloudwatch_logs_exports       = local.db_params[var.type].enabled_cloudwatch_logs_exports
  deletion_protection                   = var.deletion_protection
  apply_immediately                     = var.apply_immediately
  backup_retention_period               = var.backup_retention_period
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  final_snapshot_identifier             = "${local.instance_name}-final-snapshot"
  skip_final_snapshot                   = var.skip_final_snapshot
  backup_window                         = var.backup_window
  maintenance_window                    = var.maintenance_window
  multi_az                              = var.multi_az
  instance_class                        = var.instance_class
  storage_type                          = var.storage_type
  storage_throughput                    = var.storage_throughput
  iops                                  = var.iops
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  publicly_accessible                   = false
  auto_minor_version_upgrade            = false
  monitoring_role_arn                   = aws_iam_role.role.arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  license_model                         = contains(["mssql-se"], var.type) ? "license-included" : null
  timezone                              = local.is_mssql ? "E. South America Standard Time" : null

  tags = {
    Name               = local.instance_name
    Backup             = var.dr_backup
    StartStopScheduled = var.availability_time
  }

  depends_on = [aws_cloudwatch_log_group.rds_logs, aws_db_option_group.sqlserver_option_group]

  lifecycle {
    ignore_changes = [
      tags["StartStopScheduled"]
    ]
  }
}