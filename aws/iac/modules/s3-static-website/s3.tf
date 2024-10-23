module "bucket" {
  source            = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git?ref=main"
  component_name    = var.component_name
  environment       = var.environment
  region            = var.region
  name              = local.bucket_name
  sse_type          = "SSE-S3"
  versioning        = "Suspended"
  create_app_policy = var.create_bucket_app_policy
  cors_rules        = var.bucket_cors_rules
  expiration_rules  = var.bucket_expiration_rules
}

resource "aws_s3_bucket_policy" "bucket_oai_policy" {
  bucket = module.bucket.bucket.id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "OaiPolicy",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [for i in module.website.cloudfront_origin_access_identity_iam_arns : i]
        },
        "Resource" : [
          "arn:aws:s3:::${module.bucket.bucket.id}",
          "arn:aws:s3:::${module.bucket.bucket.id}/*"
        ]
        "Action" : [
          "s3:ListBucket",
          "s3:GetObject"
        ]
      }
    ]
  })
}

module "bucket_logs" {
  count          = var.enable_access_logs ? 1 : 0
  source         = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git?ref=main"
  component_name = var.component_name
  environment    = var.environment
  region         = var.region
  name           = local.log_bucket_name
  sse_type       = "SSE-S3"
  versioning     = "Suspended"
  transition_rules = [
    {
      prefix        = ""
      days          = 30
      storage_class = "STANDARD_IA"
    },
    {
      prefix        = ""
      days          = 90
      storage_class = "GLACIER"
    }
  ]
  expiration_rules = [{
    prefix = ""
    days   = 180
  }]
}

resource "aws_s3_bucket_policy" "bucket_logs_oai_policy" {
  count  = var.enable_access_logs ? 1 : 0
  bucket = module.bucket_logs[0].bucket.id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "OaiPolicy",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [for i in module.website.cloudfront_origin_access_identity_iam_arns : i]
        },
        "Resource" : [
          "arn:aws:s3:::${module.bucket_logs[0].bucket.id}/*"
        ]
        "Action" : [
          "s3:PutObject"
        ]
      }
    ]
  })
}
