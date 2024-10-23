# BACKUP-US COMUNICA COM SHARED-US
# BACKUP-SP COMUNICA COM SHARED-SP
# DEMAIS COMUNICACOES BLOQUEADAS

locals {
  iam_sae1_session_manager_role    = "role-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_sae1_session_manager_profile = "profile-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_role    = "role-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_profile = "profile-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_grafana_role                 = "role-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  iam_grafana_policy               = "policy-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  iam_netbackp_policy_name         = "s3-policy-${module.this_use1.custom_context_id}-netbackup"
  s3_use1_endpoint_gateway_interno = "s3-endpoint-${module.this_use1.custom_context_id}-gateway"
  s3_sae1_endpoint_gateway_interno = "s3-endpoint-${module.this_sae1.custom_context_id}-gateway"

  #########################
  # NACL SAE1
  #########################
  network_acls_sae1 = {
    default = [
      {
        rule_number = 10
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.96.0.0/16"
      },
      {
        rule_number = 20
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.92.0.0/16"
      },
      {
        rule_number = 30
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.0.0.0/8"
      },
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    ]
  }

  #########################
  # NACL USE1
  #########################
  network_acls_use1 = {
    default = [
      {
        rule_number = 10
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.86.0.0/16"
      },
      {
        rule_number = 20
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.82.0.0/16"
      },
      {
        rule_number = 30
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.0.0.0/8"
      },
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      }
    ]
  }
}
