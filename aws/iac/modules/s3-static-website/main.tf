module "website" {
  source                        = "terraform-aws-modules/cloudfront/aws"
  version                       = "3.4.1"
  create_origin_access_identity = true
  is_ipv6_enabled               = true
  aliases                       = var.aliases
  price_class                   = var.price_class
  default_root_object           = var.default_root_file
  custom_error_response         = var.custom_error_response == null ? local.custom_error_response : var.custom_error_response
  web_acl_id                    = var.waf_acl_arn

  origin_access_identities = {
    (local.oai_name) = "OAI de acesso ao bucket ${module.bucket.bucket.bucket}"
  }

  origin = {
    (local.origin_name) = {
      domain_name = module.bucket.bucket.bucket_domain_name
      s3_origin_config = {
        origin_access_identity = local.oai_name
      }

      custom_header = var.origin_custom_headers
    }
  }

  logging_config = var.enable_access_logs ? {
    bucket          = module.bucket_logs[0].bucket.bucket_domain_name
    include_cookies = var.include_cookies_for_access_logs
  } : {}

  viewer_certificate = {
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = var.minimum_protocol_version
    ssl_support_method             = "sni-only"
    cloudfront_default_certificate = false
  }

  default_cache_behavior = {
    target_origin_id            = local.origin_name
    path_pattern                = "*"
    viewer_protocol_policy      = "redirect-to-https"
    allowed_methods             = var.allowed_methods
    cached_methods              = var.cached_methods
    compress                    = var.compress
    default_ttl                 = var.default_ttl
    min_ttl                     = var.min_ttl
    max_ttl                     = var.max_ttl
    function_association        = var.function_association
    lambda_function_association = var.lambda_function_association
    response_headers_policy_id  = var.response_headers_policy_id
    cache_policy_id             = var.cache_policy_id
    use_forwarded_values        = var.use_forwarded_values
    query_string                = var.forward_query_string
  }

  ordered_cache_behavior = local.ordered_cache_behavior

  tags = {
    Name = local.website_name
  }
}
