resource "aws_rds_cluster_parameter_group" "cluster_pg" {
  name        = local.cluster_pg_name
  family      = var.parameter_group_family
  description = "Cluster Parameter Group de ${local.cluster_name}"

  dynamic "parameter" {
    for_each = var.rds_cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = {
    Name = local.cluster_pg_name
  }
}

resource "aws_db_parameter_group" "db_pg" {
  name        = local.db_pg_name
  family      = var.parameter_group_family
  description = "DB Parameter Group de ${local.cluster_name}"

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

resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_name
  }
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier              = local.cluster_name
  engine                          = local.db_params[var.type].engine
  engine_version                  = var.engine_version
  db_cluster_parameter_group_name = local.cluster_pg_name
  vpc_security_group_ids          = [aws_security_group.sg.id]
  db_subnet_group_name            = var.db_subnet_group_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = local.db_params[var.type].enabled_cloudwatch_logs_exports
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  backup_retention_period         = var.backup_retention_period
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  final_snapshot_identifier       = "${local.cluster_name}-final-snapshot"
  skip_final_snapshot             = var.skip_final_snapshot
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window

  tags = {
    Name               = local.cluster_name
    Backup             = var.dr_backup
    StartStopScheduled = var.availability_time
  }

  lifecycle {
    ignore_changes = [
      tags["StartStopScheduled"]
    ]
  }
}

resource "aws_rds_cluster_instance" "instance" {
  count                                 = var.cluster_instances
  identifier                            = "${local.instance_base_name}-${count.index + 1}"
  cluster_identifier                    = aws_rds_cluster.cluster.id
  engine                                = aws_rds_cluster.cluster.engine
  engine_version                        = aws_rds_cluster.cluster.engine_version
  copy_tags_to_snapshot                 = aws_rds_cluster.cluster.copy_tags_to_snapshot
  preferred_maintenance_window          = aws_rds_cluster.cluster.preferred_maintenance_window
  instance_class                        = var.instance_class
  apply_immediately                     = var.apply_immediately
  db_parameter_group_name               = local.db_pg_name
  db_subnet_group_name                  = var.db_subnet_group_name
  publicly_accessible                   = false
  auto_minor_version_upgrade            = false
  monitoring_role_arn                   = aws_iam_role.role.arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  tags = {
    Name               = "${local.instance_base_name}-${count.index + 1}"
    Backup             = var.dr_backup
    StartStopScheduled = var.availability_time
  }

  lifecycle {
    ignore_changes = [
      tags["StartStopScheduled"]
    ]
  }
}