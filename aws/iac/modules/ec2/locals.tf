locals {
  instance_name = "ec2-${module.this.custom_context_id}-${var.name}"
  sg_name       = "SG-ec2-${module.this.custom_context_id}-${var.name}"
  role_name     = "role-ec2-${module.this.custom_context_id}-${var.name}"
  profile_name  = "profile-ec2-${module.this.custom_context_id}-${var.name}"
  ebs_name      = "ebs-ec2-${module.this.custom_context_id}-${var.name}"
  eip_name      = "eip-ec2-${module.this.custom_context_id}-${var.name}"
  key           = "ec2-key-internal-${var.environment}-${module.this.custom_context.environment}-${var.os}"
  aws_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  hostnames = {
    dev     = "DEV"
    cer     = "CER"
    hml     = "HML"
    prd     = "PRD"
    shared  = "SHARED"
    sandbox = "SBX"
    backup  = "BKP"
    network = "NET"
    logs    = "LOG"
    audit   = "AUD"
  }

  custom_policies = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/policy-s3-internal-${var.environment}-${module.this.custom_context.environment}-ssm-resources"
  ]
  os_user_data = {
    linux   = "user_data.sh"
    windows = "user_data.ps1"
  }
  user_data       = var.user_data != null ? var.user_data : file("${path.module}/${local.os_user_data[var.os]}")
  inter_user_data = var.user_data_append != null ? format("%s%s", local.user_data, var.user_data_append) : local.user_data
  final_user_data = var.os == "windows" ? format("<powershell>\n%s\n</powershell>", local.inter_user_data) : local.inter_user_data
  tags = merge(
    var.tags,
    var.extra_tags,
    {
      Name               = local.instance_name,
      OS                 = var.os,
      PrometheusExporter = var.prometheus_exporter,
      Backup             = var.dr_backup,
      StartStopScheduled = var.availability_time
    },
    var.os == "windows" ? { Hostname = "EC2${local.hostnames[var.environment]}${upper(var.hostname)}" } : {}
  )
}
