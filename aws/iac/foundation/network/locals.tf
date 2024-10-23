locals {
  us_east_1 = "use1"
  sa_east_1 = "sae1"

  iam_sae1_session_manager_role    = "role-ec2-${module.this_sae1["shared"].custom_context_id}-global-session-manager"
  iam_sae1_session_manager_profile = "profile-ec2-${module.this_sae1["shared"].custom_context_id}-global-session-manager"
  iam_use1_session_manager_role    = "role-ec2-${module.this_use1["shared"].custom_context_id}-global-session-manager"
  iam_use1_session_manager_profile = "profile-ec2-${module.this_use1["shared"].custom_context_id}-global-session-manager"
  iam_grafana_role                 = "role-grafana-${module.this_use1["shared"].custom_context_id}-workspace-datasource"
  iam_grafana_policy               = "policy-grafana-${module.this_use1["shared"].custom_context_id}-workspace-datasource"

  dx_gateway_aws_routes_sae1 = setunion([for k, v in var.tgw_attachments_sae1 : v.cidr_block if v.on_prem], [module.vpc_egress_sae1.vpc_cidr_block])
  dx_gateway_aws_routes_use1 = setunion([for k, v in var.tgw_attachments_use1 : v.cidr_block if v.on_prem], [module.vpc_egress_use1.vpc_cidr_block])

  ########################
  # FW USE1
  ########################
  fw_use1_mgmt_subnets = {
    az1 = { cidr_block = "10.81.254.0/24", az = "us-east-1a" },
    az2 = { cidr_block = "10.81.255.0/24", az = "us-east-1b" }
  }

  fw_use1_heartbeat_subnets = {
    az1 = { cidr_block = "10.81.200.0/24", az = "us-east-1a" },
    az2 = { cidr_block = "10.81.201.0/24", az = "us-east-1b" }
  }

  fw_use1_heartbeat_rtb_name    = "rtb-${module.this_use1_v2.custom_context_id}-heartbeat-egress"
  fw_use1_mgmt_subnet_name      = "subnet-${module.this_use1_v2.custom_context_id}-mgmt-egress"
  fw_use1_heartbeat_subnet_name = "subnet-${module.this_use1_v2.custom_context_id}-heartbeat-egress"
  ########################
  # FW SAE1
  ########################

  fw_sae1_mgmt_subnets = {
    az1 = { cidr_block = "10.91.254.0/24", az = "sa-east-1a" },
    az2 = { cidr_block = "10.91.255.0/24", az = "sa-east-1b" }
  }

  fw_sae1_heartbeat_subnets = {
    az1 = { cidr_block = "10.91.200.0/24", az = "sa-east-1a" },
    az2 = { cidr_block = "10.91.201.0/24", az = "sa-east-1b" }
  }

  fw_sae1_heartbeat_rtb_name    = "rtb-${module.this_sae1_v2.custom_context_id}-heartbeat-egress"
  fw_sae1_mgmt_subnet_name      = "subnet-${module.this_sae1_v2.custom_context_id}-mgmt-egress"
  fw_sae1_heartbeat_subnet_name = "subnet-${module.this_sae1_v2.custom_context_id}-heartbeat-egress"

}