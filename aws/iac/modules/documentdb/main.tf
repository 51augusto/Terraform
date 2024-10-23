resource "aws_docdb_cluster_parameter_group" "cluster_pg" {
  count       = local.create_cluster_pg ? 1 : 0
  name        = local.cluster_pg_name
  family      = var.parameter_group_family
  description = "Cluster Parameter Group de ${local.cluster_name}"
  tags = {
    Name = local.cluster_pg_name
  }
}

resource "aws_cloudwatch_log_group" "log_group_audit" {
  name              = "${local.log_group_base_name}/audit"
  retention_in_days = var.logging_retention
  tags = {
    Name = "${local.log_group_base_name}/audit"
  }
}

resource "aws_cloudwatch_log_group" "log_group_profiler" {
  name              = "${local.log_group_base_name}/profiler"
  retention_in_days = var.logging_retention
  tags = {
    Name = "${local.log_group_base_name}/profiler"
  }
}

resource "aws_docdb_cluster" "cluster" {
  cluster_identifier              = local.cluster_name
  engine                          = "docdb"
  engine_version                  = var.engine_version
  db_cluster_parameter_group_name = local.cluster_pg_name
  vpc_security_group_ids          = [aws_security_group.sg.id]
  db_subnet_group_name            = var.db_subnet_group_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]
  deletion_protection             = var.deletion_protection
  backup_retention_period         = var.backup_retention_period
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

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count                        = var.cluster_instances
  identifier                   = "${local.instance_base_name}-${count.index + 1}"
  cluster_identifier           = aws_docdb_cluster.cluster.id
  engine                       = "docdb"
  preferred_maintenance_window = var.preferred_maintenance_window
  instance_class               = var.instance_class
  auto_minor_version_upgrade   = false

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
