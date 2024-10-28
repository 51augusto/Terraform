module "rds_aurora_mysql" {
  source                 = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/rds-aurora.git?ref=main"
  component_name         = "wordpress"
  environment            = "prd"
  region                 = "us-east-1"
  name                   = "mysql57-ecs"
  type                   = "mysql"
  engine_version         = "5.7.mysql_aurora.2.11.2"
  parameter_group_family = "aurora-mysql5.7"
  vpc_id                 = data.terraform_remote_state.wordpress.outputs.vpc_id
  db_subnet_group_name   = data.terraform_remote_state.wordpress.outputs.vpc_database_subnet_group_name
  inbound_rules = [{
    description = "Wordpress Private Subnets"
    cidr_blocks = [for i in data.aws_subnet.private_subnets : i.cidr_block]
  }]
  master_username                       = local.master_username
  master_password                       = local.master_password
  cluster_instances                     = 1
  instance_class                        = "db.t4g.medium"
  deletion_protection                   = true
  backup_retention_period               = 30
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  dr_backup                             = true
  logging_retention                     = 60
  rds_cluster_parameters = [
    {
      name         = "max_connections"
      value        = "500"
      apply_method = "pending-reboot"
    }
  ]
}
