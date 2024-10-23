locals {
  website_name    = "website-${module.this.custom_context_id}-${var.name}"
  bucket_name     = var.name # Módulo do S3 já define a Namming Convention dos buckets
  log_bucket_name = "${var.name}-log"
  oai_name        = "cf-oai-s3-${module.this.custom_context_id}-${var.name}"
  origin_name     = "cf-origin-s3-${module.this.custom_context_id}-${var.name}"
  custom_error_pages = merge({
    400 = "/badrequest.html"
    403 = "/forbidden.html"
    404 = "/notfound.html"
    405 = "/error.html"
    414 = "/error.html"
    416 = "/error.html"
    500 = "/error.html"
    501 = "/error.html"
    502 = "/error.html"
    503 = "/error.html"
    504 = "/error.html"
  }, var.custom_error_pages)
  custom_error_response = [for k, v in local.custom_error_pages : {
    error_code            = tonumber(k)
    response_code         = tonumber(k)
    response_page_path    = v
    error_caching_min_ttl = var.error_caching_min_ttl
  }]
  ordered_cache_behavior = [for o in var.ordered_cache_behavior : merge(o, { target_origin_id = local.origin_name })]
  cicd_policy_name       = "policy-cicd-website-${module.this.custom_context_id}-${var.name}"
}
