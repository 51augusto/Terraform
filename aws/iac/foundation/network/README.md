<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| tgw\_sae1 | terraform-aws-modules/transit-gateway/aws | 2.12.2 |
| tgw\_use1 | terraform-aws-modules/transit-gateway/aws | 2.12.2 |
| this\_sae1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| this\_sae1\_v2 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| this\_use1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| this\_use1\_v2 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| vpc\_egress\_sae1 | terraform-aws-modules/vpc/aws | 5.14.0 |
| vpc\_egress\_use1 | terraform-aws-modules/vpc/aws | 5.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate_private_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_private_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_public_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_public_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudformation_stack.instance_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_customer_gateway.sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_customer_gateway.use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_dx_gateway.sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_gateway_association.tgw_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |
| [aws_dx_gateway_association.tgw_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |
| [aws_dx_transit_virtual_interface.sae1_rj](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_transit_virtual_interface) | resource |
| [aws_dx_transit_virtual_interface.sae1_sp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_transit_virtual_interface) | resource |
| [aws_ec2_managed_prefix_list.anbima_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_managed_prefix_list.anbima_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_managed_prefix_list.anbima_dc_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_managed_prefix_list.anbima_dc_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_tag.dx_attachment_environment_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_environment_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_iac_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_iac_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_map_migrated_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_map_migrated_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_name_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.dx_attachment_name_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_environment_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_environment_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_iac_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_iac_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_map_migrated_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_map_migrated_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_name_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_attachments_name_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_environment_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_environment_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_iac_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_iac_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_map_migrated_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_map_migrated_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_name_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpn_attachment_name_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_transit_gateway_peering_attachment.sae1_to_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_peering_attachment) | resource |
| [aws_ec2_transit_gateway_peering_attachment_accepter.sae1_to_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_peering_attachment_accepter) | resource |
| [aws_ec2_transit_gateway_route.egress_to_workloads_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.egress_to_workloads_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.on_prem_to_egress_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.on_prem_to_workloads_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.on_prem_to_workloads_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_attach_local_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_attach_local_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_attach_sae1_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_attach_use1_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_to_egress_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.peering_to_egress_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_cross_region_sae1_communication_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_cross_region_use1_communication_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_internet_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_internet_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_intra_communication_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_intra_communication_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_egress_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_egress_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_sae1_dc_rede_10](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_sae1_dc_rede_198](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_sae1_esc_rj](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_sae1_esc_sp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_use1_dc_rede_10](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_use1_dc_rede_198](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_use1_esc_rj](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.workloads_to_firewall_use1_esc_sp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.on_prem_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.on_prem_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.peering_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.peering_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.workloads_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.workloads_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.on_prem_dx_gw_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.on_prem_dx_gw_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.on_prem_vpn_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.on_prem_vpn_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.peering_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.peering_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.workloads_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.workloads_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.egress_to_bgp_on_prem_routes_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.egress_to_bgp_on_prem_routes_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.egress_vpn_connetion_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.egress_vpn_connetion_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.workloads_to_bgp_on_prem_routes_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.workloads_to_bgp_on_prem_routes_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.workloads_vpn_connetion_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.workloads_vpn_connetion_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_flow_log.flow_log_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.flow_log_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.sae1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.use1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.grafana_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.grafana_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sae1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.use1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.grafana_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_ram_principal_association.anbima_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.anbima_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.anbima_dc_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.anbima_dc_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.anbima_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.anbima_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.anbima_dc_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.anbima_dc_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.anbima_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.anbima_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.anbima_dc_cidrs_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.anbima_dc_cidrs_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_resourcegroups_group.sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_resourcegroups_group.use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_1_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_2_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan_dc_rede_10](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan_dc_rede_198](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan_esc_rj](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan_esc_sp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_private_rtb_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_sae1_public_rtb_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_1_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_2_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan_dc_rede_10](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan_dc_rede_198](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan_esc_rj](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan_esc_sp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_private_rtb_sdwan_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.vpc_egress_use1_public_rtb_workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route_table.fw_heartbeat_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.fw_heartbeat_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.fw_heartbeat_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.fw_heartbeat_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.fw_mgmt1_subnet_to_private_az_a_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.fw_mgmt1_subnet_to_private_az_a_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.fw_mgmt2_subnet_to_private_az_b_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.fw_mgmt2_subnet_to_private_az_b_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.flow_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_subnet.fw_heartbeat_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.fw_heartbeat_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.fw_mgmt_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.fw_mgmt_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpn_connection.sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection.use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_ec2_transit_gateway_dx_gateway_attachment.sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_dx_gateway_attachment) | data source |
| [aws_ec2_transit_gateway_dx_gateway_attachment.use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_dx_gateway_attachment) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.firewall](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_certificate\_domains | Lista de domínios para certificado privado ACM. | `list(any)` | <pre>[<br/>  "*.anbima.cloud",<br/>  "dev.anbima.cloud",<br/>  "*.dev.anbima.cloud",<br/>  "hml.anbima.cloud",<br/>  "*.hml.anbima.cloud",<br/>  "cer.anbima.cloud",<br/>  "*.cer.anbima.cloud",<br/>  "prd.anbima.cloud",<br/>  "*.prd.anbima.cloud"<br/>]</pre> | no |
| public\_certificate\_domains | Lista de domínios para certificado público ACM. | `list(any)` | <pre>[<br/>  "*.anbima.com.br",<br/>  "dev.anbima.com.br",<br/>  "*.dev.anbima.com.br",<br/>  "hml.anbima.com.br",<br/>  "*.hml.anbima.com.br",<br/>  "cer.anbima.com.br",<br/>  "*.cer.anbima.com.br",<br/>  "prd.anbima.com.br",<br/>  "*.prd.anbima.com.br"<br/>]</pre> | no |
| resources | Map de objetos para gerar naming convention. | `map(object({ component_name = string, resource_id = string, environment = string }))` | `{}` | no |
| tags | Tags obrigatórias para todos os recursos. | `map(string)` | <pre>{<br/>  "Environment": "network",<br/>  "IAC": true,<br/>  "map-migrated": "d-server-01oiau1h5afqhv"<br/>}</pre> | no |
| tgw\_attachments\_sae1 | Lista de TGW attachments de todas as VPCs de SAE1 | `map(object({ tgw_attachment_id = string, cidr_block = string, name = string, suffix = string, on_prem = bool }))` | `{}` | no |
| tgw\_attachments\_use1 | Lista de TGW attachments de todas as VPCs de USE1 | `map(object({ tgw_attachment_id = string, cidr_block = string, name = string, suffix = string, on_prem = bool }))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| acm\_sae1\_certificate\_private | Certificado privado de sa-east-1. |
| acm\_sae1\_certificate\_public | Certificado público de sa-east-1. |
| acm\_use1\_certificate\_private | Certificado privado de us-east-1. |
| acm\_use1\_certificate\_public | Certificado público de us-east-1. |
| anbima\_cidrs\_pl\_sae1\_id | ID do prefix list com os ranges de IP da rede interna da ANBIMA |
| anbima\_cidrs\_pl\_use1\_id | ID do prefix list com os ranges de IP da rede interna da ANBIMA |
| anbima\_dc\_cidrs\_pl\_sae1\_id | ID do prefix list com os ranges de IP do DC ANBIMA |
| anbima\_dc\_cidrs\_pl\_use1\_id | ID do prefix list com os ranges de IP do DC ANBIMA |
| tgw\_sae1\_id | ID do TGW de São Paulo. |
| tgw\_use1\_id | ID do TGW de Virgínia. |
| vpc\_sae1\_fw\_heartbeat\_subnets\_cidr\_blocks | CIDR blocks das subnets de Firewall Heartbeat da VPC de SAE1 |
| vpc\_sae1\_fw\_heartbeat\_subnets\_ids | IDs das subnets de Firewall Heartbeat da VPC de SAE1 |
| vpc\_sae1\_fw\_mgmt\_subnets\_cidr\_blocks | CIDR blocks das subnets de Firewall Mgmt da VPC de SAE1 |
| vpc\_sae1\_fw\_mgmt\_subnets\_ids | IDs das subnets de Firewall Mgmt da VPC de SAE1 |
| vpc\_sae1\_id | ID da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_ids | IDs das subnets privadas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_ids | IDs das subnets públicas da VPC de SAE1 |
| vpc\_use1\_fw\_heartbeat\_subnets\_cidr\_blocks | CIDR blocks das subnets de Firewall Heartbeat da VPC de USE1 |
| vpc\_use1\_fw\_heartbeat\_subnets\_ids | IDs das subnets de Firewall Heartbeat da VPC de USE1 |
| vpc\_use1\_fw\_mgmt\_subnets\_cidr\_blocks | CIDR blocks das subnets de Firewall Mgmt da VPC de USE1 |
| vpc\_use1\_fw\_mgmt\_subnets\_ids | IDs das subnets de Firewall Mgmt da VPC de USE1 |
| vpc\_use1\_id | ID da VPC de USE1 |
| vpc\_use1\_private\_subnets\_ids | IDs das subnets privadas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_ids | IDs das subnets públicas da VPC de USE1 |
<!-- END_TF_DOCS -->