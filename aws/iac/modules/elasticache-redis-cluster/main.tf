resource "aws_elasticache_parameter_group" "redis_pg" {
  count  = var.parameters == null ? 0 : 1
  name   = local.pg_name
  family = var.pg_family

  description = "Parameter Group de ${var.name}"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = {
    Name = local.pg_name
  }

}

resource "aws_elasticache_replication_group" "redis" {
  automatic_failover_enabled = var.number_cache_clusters > 1 ? true : false
  replication_group_id       = var.name
  description                = var.description
  node_type                  = var.node_type
  num_cache_clusters         = var.number_cache_clusters
  engine                     = "redis"
  engine_version             = var.redis_engine_version
  port                       = var.port
  subnet_group_name          = var.subnet_group_name
  security_group_ids         = var.security_group_ids == null ? [aws_security_group.sg[0].id] : var.security_group_ids
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true
  apply_immediately          = var.apply_immediately
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = false
  multi_az_enabled           = var.number_cache_clusters > 1 ? true : false
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window            = var.snapshot_window
  parameter_group_name       = var.parameters == null ? null : aws_elasticache_parameter_group.redis_pg[0].name

  tags = {
    Name   = local.name
    Backup = var.dr_backup
  }

}