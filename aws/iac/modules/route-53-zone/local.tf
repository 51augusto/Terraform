locals {
  public_domain_name  = var.public_sub_domain_name == "" ? var.public_domain_name : local.public_sub_domain_name
  private_domain_name = var.private_sub_domain_name == "" ? var.private_domain_name : local.private_sub_domain_name

  public_sub_domain_name  = "${var.public_sub_domain_name}.${var.public_domain_name}"
  private_sub_domain_name = "${var.private_sub_domain_name}.${var.private_domain_name}"
}