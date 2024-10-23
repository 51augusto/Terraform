locals {
  db_subnet_group_sae1_name       = "subnetgroup-rds-${module.this_sae1.custom_context_id}"
  db_subnet_group_use1_name       = "subnetgroup-rds-${module.this_use1.custom_context_id}"
  redshift_subnet_group_sae1_name = "subnetgroup-redshift-${module.this_sae1.custom_context_id}"
  redshift_subnet_group_use1_name = "subnetgroup-redshift-${module.this_use1.custom_context_id}"
  databricks_subnet_name          = "subnet-${module.this_use1.custom_context_id}-databricks-main"

  iam_sae1_session_manager_role    = "role-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_sae1_session_manager_profile = "profile-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_role    = "role-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_profile = "profile-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_grafana_role                 = "role-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  iam_grafana_policy               = "policy-grafana-${module.this_use1.custom_context_id}-workspace-datasource"

  r53_resolver_endpoints_ips_use1 = setunion(
    data.aws_route53_resolver_endpoint.indound_use1.ip_addresses,
    data.aws_route53_resolver_endpoint.outbound_use1.ip_addresses
  )
  r53_resolver_endpoints_ips_sae1 = setunion(
    data.aws_route53_resolver_endpoint.indound_sae1.ip_addresses,
    data.aws_route53_resolver_endpoint.outbound_sae1.ip_addresses
  )

  r53_resolver_endpoints_enis_use1 = data.aws_network_interfaces.r53_resolver_enis_use1.ids
  r53_resolver_endpoints_enis_sae1 = data.aws_network_interfaces.r53_resolver_enis_sae1.ids

  databricks_subnets = {
    az1 = { cidr_block = "10.82.40.0/22", az = "us-east-1a" },
    az2 = { cidr_block = "10.82.44.0/22", az = "us-east-1b" },
    az3 = { cidr_block = "10.82.48.0/22", az = "us-east-1c" },
  }
}