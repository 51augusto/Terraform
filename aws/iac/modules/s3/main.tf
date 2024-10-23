resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name

  tags = {
    Name   = local.bucket_name
    Backup = var.dr_backup
  }
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_sse" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    bucket_key_enabled = local.sse_config.bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm = local.sse_config.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  count  = length(var.expiration_rules) > 0 || length(var.transition_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = var.expiration_rules
    iterator = rule
    content {
      id     = "expiration-rule-${rule.key}"
      status = "Enabled"

      filter {
        prefix = rule.value["prefix"]
      }

      expiration {
        days = rule.value["days"]
      }
    }
  }

  dynamic "rule" {
    for_each = var.transition_rules
    iterator = rule
    content {
      id     = "transition-rule-${rule.key}"
      status = "Enabled"

      filter {
        prefix = rule.value["prefix"]
      }

      transition {
        days          = rule.value["days"]
        storage_class = rule.value["storage_class"]
      }
    }
  }

  dynamic "rule" {
    for_each = var.noncurr_expiration_rules
    iterator = rule
    content {
      id     = "noncurr-expiration-rule-${rule.key}"
      status = "Enabled"

      filter {
        prefix = rule.value["prefix"]
      }

      noncurrent_version_expiration {
        noncurrent_days = rule.value["days"]
      }
    }
  }

  dynamic "rule" {
    for_each = var.noncurr_transition_rules
    iterator = rule
    content {
      id     = "noncurr-transition-rule-${rule.key}"
      status = "Enabled"

      filter {
        prefix = rule.value["prefix"]
      }

      noncurrent_version_transition {
        noncurrent_days = rule.value["days"]
        storage_class   = rule.value["storage_class"]
      }
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
  count  = length(var.cors_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  dynamic "cors_rule" {
    for_each = var.cors_rules
    iterator = rule
    content {
      allowed_headers = rule.value["allowed_headers"]
      allowed_methods = rule.value["allowed_methods"]
      allowed_origins = rule.value["allowed_origins"]
      expose_headers  = rule.value["expose_headers"]
      max_age_seconds = rule.value["max_age_seconds"]
    }
  }
}

resource "aws_s3_bucket_policy" "public" {
  count = var.public_bucket ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.bucket_public_access_block]
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = !var.public_bucket
  ignore_public_acls      = true
  restrict_public_buckets = !var.public_bucket
}

resource "aws_s3_bucket_object_lock_configuration" "object_lock" {
  count                 = var.object_lock_configuration != null ? 1 : 0
  bucket                = aws_s3_bucket.bucket.id
  expected_bucket_owner = data.aws_caller_identity.current.account_id


  dynamic "rule" {
    for_each = var.object_lock_configuration.days > 0 ? [1] : []
    content {
      default_retention {
        mode = var.object_lock_configuration.mode
        days = var.object_lock_configuration.days
      }
    }
  }


  depends_on = [aws_s3_bucket_versioning.bucket_versioning]
}
