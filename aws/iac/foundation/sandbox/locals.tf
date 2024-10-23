locals {
  iam_sae1_session_manager_role    = "role-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_sae1_session_manager_profile = "profile-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_role    = "role-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_profile = "profile-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_grafana_role                 = "role-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  iam_grafana_policy               = "policy-grafana-${module.this_use1.custom_context_id}-workspace-datasource"

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
        cidr_block  = "10.95.0.0/16"
      },
      {
        rule_number = 90
        rule_action = "deny"
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
        cidr_block  = "10.87.0.0/16"
      },
      {
        rule_number = 90
        rule_action = "deny"
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