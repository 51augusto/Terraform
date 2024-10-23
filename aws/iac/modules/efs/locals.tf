locals {
  efs_fs_name      = "efs-fs-${module.this.custom_context_id}"
  efs_ap_base_name = "efs-ap-${module.this.custom_context_id}"
  sg_name          = "SG-efs-${module.this.custom_context_id}"
}