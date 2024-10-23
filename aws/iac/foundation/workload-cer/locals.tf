locals {
  iam_sae1_session_manager_role      = "role-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_sae1_session_manager_profile   = "profile-ec2-${module.this_sae1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_role      = "role-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_use1_session_manager_profile   = "profile-ec2-${module.this_use1.custom_context_id}-global-session-manager"
  iam_grafana_role                   = "role-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  iam_grafana_policy                 = "policy-grafana-${module.this_use1.custom_context_id}-workspace-datasource"
  s3_use1_endpoint_gateway_interno   = "s3-endpoint-${module.this_use1.custom_context_id}-gateway"
  elasticache_subnet_group_sae1_name = "subnetgroup-elasticache-${module.this_sae1.custom_context_id}"
  elasticache_subnet_group_use1_name = "subnetgroup-elasticache-${module.this_use1.custom_context_id}"

  #########################
  # NACL SAE1
  #########################
  network_acls_sae1 = {
    default = [
      ## VPC DE WORKLOAD-CER ##
      {
        rule_number = 10
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.56.0.0/16"
      },
      ## VPC DE SHARED-SERVICES ##
      {
        rule_number = 20
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.92.0.0/16"
      },
      ## VPC DE WORKLOAD-PRD ##
      {
        rule_number = 30
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.52.0.0/16"
      },
      ## VPC DE WORKLOAD-DEV ##
      {
        rule_number = 40
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.58.0.0/16"
      },
      ## VPC DE WORKLOAD-HML ##
      {
        rule_number = 50
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.54.0.0/16"
      },
      ## VPC DE WORKLOAD-PRD - USE1 ##
      {
        rule_number = 60
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.62.0.0/16"
      },
      ## VPC DE WORKLOAD-HML - USE1 ##
      {
        rule_number = 70
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.64.0.0/16"
      },
      ## VPC DE WORKLOAD-CER - USE1 ##
      {
        rule_number = 80
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.66.0.0/16"
      },
      ## VPC DE WORKLOAD-DEV - USE1 ##
      {
        rule_number = 90
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.68.0.0/16"
      },
      ## INTERNET E ONPREMISES ##
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
      ## VPC DE WORDPRESS ##
      {
        rule_number = 100
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.60.0.0/16"
      },

    ]
  }

  #########################
  # NACL USE1
  #########################
  network_acls_use1 = {
    default = [
      ## VPC DE WORKLOAD-CER ##
      {
        rule_number = 10
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.66.0.0/16"
      },
      ## VPC DE SHARED-SERVICES ##
      {
        rule_number = 20
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.82.0.0/16"
      },
      ## VPC DE WORKLOAD-PRD ##
      {
        rule_number = 30
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.62.0.0/16"
      },
      ## VPC DE WORKLOAD-DEV ##
      {
        rule_number = 40
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.68.0.0/16"
      },
      ## VPC DE WORKLOAD-HML ##
      {
        rule_number = 50
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.64.0.0/16"
      },
      ## VPC DE WORKLOAD-PRD - SAE1 ##
      {
        rule_number = 60
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.52.0.0/16"
      },
      ## VPC DE WORKLOAD-HML - SAE1 ##
      {
        rule_number = 70
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.54.0.0/16"
      },
      ## VPC DE WORKLOAD-CER - SAE1 ##
      {
        rule_number = 80
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.56.0.0/16"
      },
      ## VPC DE WORKLOAD-DEV - SAE1 ##
      {
        rule_number = 90
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.58.0.0/16"
      },
      ## INTERNET E ONPREMISES ##
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "0.0.0.0/0"
      },
      ## VPC DE WORDPRESS ##
      {
        rule_number = 100
        rule_action = "deny"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_block  = "10.60.0.0/16"
      }
    ]
  }
}