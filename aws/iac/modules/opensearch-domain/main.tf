resource "aws_opensearch_domain" "domain" {
  domain_name      = local.domain_name
  engine_version   = var.engine_version
  advanced_options = var.advanced_options

  cluster_config {
    dedicated_master_enabled = var.dedicated_masters != null
    dedicated_master_count   = var.dedicated_masters != null ? var.dedicated_masters.count : null
    dedicated_master_type    = var.dedicated_masters != null ? var.dedicated_masters.type : null
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    zone_awareness_enabled   = var.multi_az

    dynamic "zone_awareness_config" {
      for_each = var.multi_az ? [1] : []
      content {
        availability_zone_count = length(var.subnet_ids)
      }
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.storage_type
    volume_size = var.storage_size
    iops        = var.storage_iops
    throughput  = var.storage_throughput
  }

  domain_endpoint_options {
    custom_endpoint_enabled         = true
    enforce_https                   = true
    tls_security_policy             = var.endpoint_tls_policy
    custom_endpoint                 = var.endpoint_domain
    custom_endpoint_certificate_arn = var.endpoint_certificate_arn
  }

  auto_tune_options {
    desired_state       = var.enable_auto_tune ? "ENABLED" : "DISABLED"
    rollback_on_disable = "NO_ROLLBACK"
  }

  vpc_options {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids == null ? [aws_security_group.sg[0].id] : var.security_group_ids
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = var.use_default_kms ? null : aws_kms_key.kms_key[0].key_id
  }

  node_to_node_encryption {
    enabled = true
  }

  off_peak_window_options {
    enabled = true
    off_peak_window {
      window_start_time {
        hours   = var.off_peak_window_start.hours
        minutes = var.off_peak_window_start.minutes
      }
    }
  }

  advanced_security_options {
    enabled                        = true
    anonymous_auth_enabled         = false
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.master_username
      master_user_password = var.master_password
    }
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.log_group_index_slow.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.log_group_search_slow.arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.log_group_es_application.arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.log_group_audit.arn
    log_type                 = "AUDIT_LOGS"
  }

  access_policies = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "es:*",
        "Principal" : "*",
        "Effect" : "Allow",
        "Resource" : "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.domain_name}/*"
      }
    ]
  })

  tags = {
    Name   = local.domain_name
    Backup = var.dr_backup
  }
}

resource "aws_opensearch_domain_saml_options" "saml" {
  count       = var.saml_config != null ? 1 : 0
  domain_name = aws_opensearch_domain.domain.domain_name
  saml_options {
    enabled = true
    idp {
      entity_id        = var.saml_config.entity_id
      metadata_content = var.saml_config.metadata_content
    }
    master_backend_role     = var.saml_config.master_backend_role
    master_user_name        = var.saml_config.master_username
    roles_key               = var.saml_config.roles_key
    session_timeout_minutes = var.saml_config.session_timeout_minutes
    subject_key             = var.saml_config.subject_key
  }
}

resource "aws_kms_alias" "kms_key_alias" {
  count         = var.use_default_kms ? 0 : 1
  name          = local.kms_key_alias
  target_key_id = aws_kms_key.kms_key[0].key_id
}

resource "aws_kms_key" "kms_key" {
  count                    = var.use_default_kms ? 0 : 1
  description              = "Chave KMS para encriptação do OpenSearch Domain ${local.domain_name}"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  deletion_window_in_days  = 30
  is_enabled               = true
  multi_region             = false
  enable_key_rotation      = false
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "default",
    "Statement" : [
      {
        "Sid" : "Admin",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : [
          "kms:*"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access through OpenSearch Service for all principals in the account that are authorized to use OpenSearch Service",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:CreateGrant",
          "kms:DescribeKey"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "kms:ViaService" : "es.${data.aws_region.current.name}.amazonaws.com",
            "kms:CallerAccount" : data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        "Sid" : "Allow OpenSearch service principals to describe the key directly",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "es.amazonaws.com"
        },
        "Action" : [
          "kms:Describe*",
          "kms:Get*",
          "kms:List*"
        ],
        "Resource" : "*"
      }
    ]
  })
}
