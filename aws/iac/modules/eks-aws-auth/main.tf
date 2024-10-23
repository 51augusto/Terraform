locals {
  region_code    = var.region == "us-east-1" ? "use1" : var.region == "sa-east-1" ? "sae1" : null
  k8s_sso_admins = ["ADMIN", "MAINTAINER", "BRLINK_ADMIN", "BRLINK_MAINTAINER", "EKS_MAINTAINER"]

  ##############################################################
  #                       NÃO MEXER
  ##############################################################
  k8s_break_glass_aws_auth = [{
    rolearn  = tolist(data.aws_iam_roles.break_glass.arns)[0]
    username = "break_glass_user",
    groups   = ["system:masters"]
    }
  ]
  ##############################################################

  k8s_users_admin_aws_auth = { for k in local.k8s_sso_admins :
    k => {
      rolearn  = replace(tolist(data.aws_iam_roles.sso_admins[k].arns)[0], "//aws-reserved/sso.amazonaws.com/", "")
      username = lower(k),
      groups   = ["system:masters"]
    }
  }

  k8s_cicd_aws_auth = { for k in var.app_names_for_k8s_cicd :
    k => {
      rolearn  = tolist(data.aws_iam_roles.cicd[k].arns)[0],
      username = "cicd_${lower(k)}"
      groups   = []
    }
  }

  k8s_cicd_iac_aws_auth = [{
    rolearn  = data.aws_iam_role.cicd_iac.arn
    username = "cicd_iac",
    groups   = ["system:masters"]
    }
  ]

  k8s_ops_aws_auth = { for k in var.app_names_for_k8s_ops :
    k => {
      rolearn  = tolist(data.aws_iam_roles.ops[k].arns)[0],
      username = "ops_${lower(k)}"
      groups   = []
    }
  }

  k8s_users_ro_aws_auth = { for k in var.app_names_for_k8s_users :
    k => {
      rolearn  = replace(tolist(data.aws_iam_roles.app_ro[k].arns)[0], "//aws-reserved/sso.amazonaws.com/", ""),
      username = "${lower(k)}_ro"
      groups   = []
    }
  }

  k8s_users_editor_aws_auth = { for k in var.app_names_for_k8s_users :
    k => {
      rolearn  = replace(tolist(data.aws_iam_roles.app_editor[k].arns)[0], "//aws-reserved/sso.amazonaws.com/", ""),
      username = "${lower(k)}_editor",
      groups   = []
    }
  }

  extra_auths = { for k, v in var.extra_auths :
    v.username => {
      rolearn  = v.rolearn
      username = v.username,
      groups   = []
    }
  }

  extra_sso_auths = { for k, v in var.extra_sso_auths :
    v.username => {
      rolearn  = replace(tolist(data.aws_iam_roles.extra_sso_auths[v.permission_set_name].arns)[0], "//aws-reserved/sso.amazonaws.com/", ""),
      username = v.username,
      groups   = []
    }
  }

  extra_sso_auths_for_each = [for k, v in var.extra_sso_auths : v.permission_set_name]

  roles_aws_auth = concat(
    values(local.k8s_users_admin_aws_auth),
    values(local.k8s_cicd_aws_auth),
    values(local.k8s_ops_aws_auth),
    values(local.k8s_users_ro_aws_auth),
    values(local.k8s_users_editor_aws_auth),
    ########### NÃO MEXER ############
    local.k8s_break_glass_aws_auth,
    ##################################
    values(local.extra_auths),
    values(local.extra_sso_auths),
    local.k8s_cicd_iac_aws_auth
  )
}