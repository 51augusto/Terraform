locals {
  delimiter = "-"
  regions = {
    us-east-1      = "use1"
    sa-east-1      = "sae1",
    us-east-2      = "use2"
    us-west-1      = "usw1"
    us-west-2      = "usw2"
    ap-south-1     = "aps1"
    ap-northeast-1 = "apne1"
    ap-northeast-2 = "apne2"
    ap-northeast-3 = "apne3"
    ap-southeast-1 = "apse1"
    ap-southeast-2 = "apse2"
    ca-central-1   = "cac1"
    ca-west-1      = "caw1"
    eu-central-1   = "euc1"
    eu-west-1      = "euw1"
    eu-west-2      = "euw2"
    eu-west-3      = "euw3"
    eu-north-1     = "eun1"
  }

  default_context = {
    enabled             = true
    tenant              = null
    environment         = local.regions[var.region]
    name                = null
    stage               = null
    attributes          = []
    namespace           = null
    delimiter           = local.delimiter
    labels_as_tags      = ["unset"]
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = ["attributes", "namespace", "tenant", "stage", "environment", "name"]
    id_length_limit     = null
    label_key_case      = "title"
    label_value_case    = "none"
    descriptor_formats = {
      stack = {
        labels = ["tenant", "stage", "environment"]
        format = "%v-%v-%v"
      }
    }
  }

  actual_context = merge(local.default_context, { tags = {}, stage = var.environment })

  aldo_context = {
    region         = module.custom.context.environment
    environment    = module.custom.context.stage
    component_name = module.custom.context.tenant
  }
}
