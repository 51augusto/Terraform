module "root" {
  source         = "cloudposse/label/null"
  version        = "0.25.0"
  context        = local.actual_context
  labels_as_tags = []
}

module "custom" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  tenant  = lower(var.component_name)
  context = module.root.context
}