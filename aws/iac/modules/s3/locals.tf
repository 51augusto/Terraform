locals {
  bucket_name     = "s3-${module.this.custom_context_id}-${var.name}"
  app_policy_name = "policy-app-s3-${module.this.custom_context_id}-${var.name}"

  sse_config_kms = {
    bucket_key_enabled = true,
    sse_algorithm      = "aws:kms"
  }
  sse_config_s3 = {
    bucket_key_enabled = null,
    sse_algorithm      = "AES256"
  }
  sse_config = var.sse_type == "SSE-KMS" ? local.sse_config_kms : local.sse_config_s3
}
