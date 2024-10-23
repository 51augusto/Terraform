module "s3_netbackup" {
  providers      = { aws = aws.use1 }
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git?ref=main"
  name           = "netbackup"
  component_name = "internal"
  environment    = "backup"
  expiration_rules = [
    {
      prefix = "*",
      days   = 1830
    }
  ]
  region   = "us-east-1"
  sse_type = "SSE-KMS"
  transition_rules = [
    {
      prefix        = "*",
      days          = 35,
      storage_class = "STANDARD_IA"
    },
    {
      prefix        = "*",
      days          = 180,
      storage_class = "GLACIER"
    }
  ]
}

resource "aws_iam_policy" "policy_s3_netbackup" {
  provider = aws.use1
  name     = local.iam_netbackp_policy_name
  path     = "/"
  policy   = data.aws_iam_policy_document.netbackup_policy.json
  tags     = { Name = local.iam_netbackp_policy_name }
}

module "s3_backup_historico" {
  providers      = { aws = aws.use1 }
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git?ref=main"
  name           = "backup-historico"
  component_name = "internal"
  environment    = "backup"
  transition_rules = [
    {
      prefix        = "*",
      days          = 35,
      storage_class = "STANDARD_IA"
    },
    {
      prefix        = "*",
      days          = 180,
      storage_class = "GLACIER"
    }
  ]
}
