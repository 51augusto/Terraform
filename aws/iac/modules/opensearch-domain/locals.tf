locals {
  domain_name              = "es-${module.this.custom_context_id}-${var.name}"
  sg_name                  = "SG-${local.domain_name}"
  kms_key_alias            = "alias/kms-key-${local.domain_name}"
  log_group_prefix         = "/aws/opensearch/${local.domain_name}"
  log_group_index_slow     = "${local.log_group_prefix}/index-slow"
  log_group_search_slow    = "${local.log_group_prefix}/search-slow"
  log_group_es_application = "${local.log_group_prefix}/es-application"
  log_group_audit          = "${local.log_group_prefix}/audit"
  log_policy_name          = "policy-${local.domain_name}-logs"

  pl_ids = var.region == "us-east-1" ? data.terraform_remote_state.network.outputs.anbima_cidrs_pl_use1_id : var.region == "sa-east-1" ? data.terraform_remote_state.network.outputs.anbima_cidrs_pl_sae1_id : []
}