resource "aws_iam_role" "ec2_role" {
  count       = var.ec2_polices_arns != null ? 1 : 0
  name        = local.ec2_role_name
  description = "Role para instâncias EC2 da aplicação ${var.app}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = var.ec2_polices_arns
  tags = {
    Name = local.ec2_role_name
  }
}

resource "aws_iam_role" "eks_role" {
  for_each    = var.eks_applications
  name        = "${local.eks_role_name}-${each.value.app_name}"
  description = "Role para Pods da aplicação ${title(var.app)} - ${title(each.value.app_name)}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/role-eks-cluster-shared-${var.environment}-${module.this.anbima_context.region}-workers"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = each.value.eks_policies_arns

  tags = {
    Name = "${local.eks_role_name}-${each.value.app_name}"
  }
}

resource "aws_iam_role" "eks_single_role" {
  count       = var.eks_polices_arns != null ? 1 : 0
  name        = local.eks_role_name
  description = "Role para Pods da aplicação ${var.app}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/role-eks-cluster-shared-${var.environment}-${module.this.anbima_context.region}-workers"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = var.eks_polices_arns
  tags = {
    Name = local.eks_role_name
  }
}

resource "aws_iam_role" "ecs_role" {
  for_each    = var.ecs_applications
  name        = "${local.ecs_role_name}-${each.value.app_name}"
  description = "Role para Tasks da aplicação ${title(var.app)} - ${title(each.value.app_name)}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = each.value.ecs_policies_arns

  tags = {
    Name = "${local.ecs_role_name}-${each.value.app_name}"
  }
}

resource "aws_iam_role" "cicd_role" {
  name                 = local.cicd_role_name
  description          = "Role para processos de CI/CD da aplicação ${var.app}"
  max_session_duration = var.cicd_max_session_duration
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = "arn:aws:iam::788006387775:root"
      },
      Action = "sts:AssumeRole",
      Condition = {
        "ForAllValues:ArnLike" = {
          "aws:SourceArn" = "arn:aws:iam::788006387775:role/role-ec2-cicd-shared-use1-gitlab-*"
        }
      }
      }
    ]
  })
  managed_policy_arns = setunion(var.cicd_polices_arns, [aws_iam_policy.cicd_policy.arn])

  tags = {
    Name = local.cicd_role_name
  }
}

resource "aws_iam_policy" "cicd_policy" {
  name        = local.cicd_policy_name
  path        = "/"
  description = "Policy padrão para processos de CI/CD em cluster EKS."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:RegisterTaskDefinition",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTaskDefinition",
          "ecs:DeregisterTaskDefinition",
          "ecs:ListServices"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = {
    Name = local.cicd_policy_name
  }
}

resource "aws_iam_policy" "ops_policy" {
  name        = local.ops_policy_name
  path        = "/"
  description = "Policy padrão para processos de operações em cluster EKS."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = local.ops_policy_name
  }
}

resource "aws_iam_policy" "ops_start_stop_policy" {
  name        = local.ops_start_stop_policy_name
  path        = "/"
  description = "Policy padrão para processos de Start/Stop nos recursos AWS."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "ec2:DescribeInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "ModificacaoDeTagStartStopScheduled"
        Action = [
          "ec2:CreateTags",
          "rds:AddTagsToResource",
          "rds:RemoveTagsFromResource"
        ]
        Effect   = "Allow"
        Resource = "*",
        Condition = {
          "ForAnyValue:StringEquals" = {
            "aws:ResourceTag/Application" = data.aws_default_tags.this.tags.Application
          },
          "ForAllValues:StringEquals" = {
            "aws:TagKeys" : "StartStopScheduled"
          },
          "StringLike" = {
            "aws:RequestTag/StartStopScheduled" : [
              "*"
            ]
          },
        }
      }
    ]
  })

  tags = {
    Name = local.ops_start_stop_policy_name
  }
}

resource "aws_iam_role" "ops_role" {
  name                 = local.ops_role_name
  description          = "Role para ser utilizada por ferramentas de Operações da aplicação ${var.app}"
  max_session_duration = var.ops_max_session_duration
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = "arn:aws:iam::788006387775:root"
      },
      Action = "sts:AssumeRole",
      Condition = {
        "ForAllValues:ArnLike" = {
          "aws:SourceArn" = [
            "arn:aws:iam::788006387775:role/role-ec2-rundeck-shared-use1-rundeck-*",
            "arn:aws:iam::788006387775:role/role-ec2-cicd-shared-use1-gitlab-*"
          ]
        }
      }
      }
    ]
  })
  managed_policy_arns = setunion(var.ops_policies_arns, [aws_iam_policy.ops_policy.arn, aws_iam_policy.ops_start_stop_policy.arn])
  tags = {
    Name = local.ops_role_name
  }
}