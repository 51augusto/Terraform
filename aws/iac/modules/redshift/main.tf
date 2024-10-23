resource "aws_redshift_parameter_group" "pg" {
  count       = local.create_cluster_pg ? 1 : 0
  name        = local.cluster_pg_name
  family      = var.parameter_group_family
  description = "Redshift Cluster Parameter Group de ${local.cluster_name}"
  tags = {
    Name = local.cluster_pg_name
  }
}

resource "aws_redshift_cluster" "cluster" {
  cluster_identifier                  = local.cluster_name
  database_name                       = var.database_name
  cluster_version                     = var.cluster_version
  node_type                           = var.node_type
  cluster_type                        = var.cluster_type
  number_of_nodes                     = var.number_of_nodes
  cluster_parameter_group_name        = local.cluster_pg_name
  vpc_security_group_ids              = [aws_security_group.sg.id]
  cluster_subnet_group_name           = var.cluster_subnet_group_name
  availability_zone                   = var.availability_zone
  enhanced_vpc_routing                = var.enhanced_vpc_routing
  publicly_accessible                 = false
  master_username                     = var.master_username
  master_password                     = var.master_password
  encrypted                           = true
  allow_version_upgrade               = var.allow_version_upgrade
  automated_snapshot_retention_period = var.automated_snapshot_retention_period
  final_snapshot_identifier           = "${local.cluster_name}-final-snapshot"
  skip_final_snapshot                 = var.skip_final_snapshot
  preferred_maintenance_window        = var.preferred_maintenance_window
  iam_roles                           = var.iam_roles

  logging {
    enable        = var.logging.enable
    bucket_name   = var.logging.bucket_name
    s3_key_prefix = var.logging.s3_key_prefix
  }

  tags = {
    Name   = local.cluster_name
    Backup = var.dr_backup
  }
}