data "aws_ssoadmin_instances" "this" {}

data "aws_identitystore_group" "ro" {
  for_each = var.sso_applications

  identity_store_id = local.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "GR_AWS_${upper(each.key)}_RO"
    }
  }
}

data "aws_identitystore_group" "dev" {
  for_each = var.sso_applications

  identity_store_id = local.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "GR_AWS_${upper(each.key)}_DEV"
    }
  }
}

data "aws_identitystore_group" "owner" {
  for_each = var.sso_applications

  identity_store_id = local.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "GR_AWS_${upper(each.key)}_OWNER"
    }
  }
}

data "aws_iam_policy_document" "editor" {
  for_each = var.sso_applications

  statement {
    sid       = "PermissaoDeModificacaoDelecaoParaRecursosDaAplicacao"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "applicationinsights:Update*",
      "athena:Start*",
      "athena:Stop*",
      "athena:Update*",
      "autoscaling:AttachInstances",
      "autoscaling:Cancel*",
      "autoscaling:Complete*",
      "autoscaling:DetachLoadBalancers",
      "autoscaling:Put*",
      "autoscaling:Set*",
      "autoscaling:Start*",
      "autoscaling:Terminate*",
      "autoscaling:Update*",
      "cloud9:ActivateEC2Remote",
      "cloud9:Modify*",
      "cloud9:Update*",
      "cloudformation:ActivateType",
      "cloudformation:Cancel*",
      "cloudformation:ContinueUpdate*",
      "cloudformation:ExecuteChangeSet*",
      "cloudformation:Register*",
      "cloudformation:Stop*",
      "cloudformation:Update*",
      "cloudfront:Associate*",
      "cloudfront:Publish*",
      "cloudfront:Test*",
      "cloudfront:Update*",
      "cloudshell:Put*",
      "cloudshell:Start*",
      "cloudshell:Stop*",
      "cloudwatch:Disable*",
      "cloudwatch:Enable*",
      "cloudwatch:Put*",
      "cloudwatch:Set*",
      "cloudwatch:Start*",
      "cloudwatch:Stop*",
      "datapipeline:*",
      "ebs:Complete*",
      "ebs:Get*",
      "ebs:Put*",
      "ebs:Start*",
      "ec2:Modify*",
      "ec2:Put*",
      "ec2:Start*",
      "ec2:Stop*",
      "ec2:Update*",
      "ecr:Put*",
      "eks:TagResource",
      "eks:Update*",
      "elasticache:Authorize*",
      "elasticache:DecreaseNodeGroupsInGlobalReplicationGroup",
      "elasticache:Failover*",
      "elasticache:IncreaseNodeGroupsInGlobalReplicationGroup",
      "elasticache:Modify*",
      "elasticache:ReSet*",
      "elasticache:RebootCacheCluster",
      "elasticache:Revoke*",
      "elasticache:Start*",
      "elasticfilesystem:Modify*",
      "elasticfilesystem:Put*",
      "elasticloadbalancing:Apply*",
      "elasticloadbalancing:Attach*",
      "elasticloadbalancing:Configure*",
      "elasticloadbalancing:Deregister*",
      "elasticloadbalancing:Detach*",
      "elasticloadbalancing:Disable*",
      "elasticloadbalancing:Enable*",
      "elasticloadbalancing:Modify*",
      "elasticloadbalancing:Register*",
      "elasticloadbalancing:Remove*",
      "elasticloadbalancing:Set*",
      "events:ActivateEventSource",
      "events:CancelReplay",
      "events:DeactivateEventSource",
      "events:DeauthorizeConnection",
      "events:DisableRule",
      "events:EnableRule",
      "events:InvokeApiDestination",
      "events:Put*",
      "events:RemoveTargets",
      "events:StartReplay",
      "events:Update*",
      "execute-api:*",
      "kafka:UpdateBrokerCount",
      "kms:Decrypt",
      "kms:EnableKey",
      "kms:Encrypt",
      "kms:Update*",
      "lambda:Invoke*",
      "lambda:Publish*",
      "lambda:Put*",
      "lambda:Update*",
      "logs:Put*",
      "logs:Update*",
      "mq:Update*",
      "rds-data:BatchExecuteStatement",
      "rds-data:BeginTransaction",
      "rds-data:CommitTransaction",
      "rds-data:ExecuteSql",
      "rds-data:RollbackTransaction",
      "rds:Add*",
      "rds:Failover*",
      "rds:Modify*",
      "rds:PromoteReadReplica",
      "rds:RebootDBInstance",
      "rds:RestoreDBInstanceFromS3",
      "rds:Revoke*",
      "rds:Stop*",
      "redshift:Modify*",
      "redshift:RestoreTableFromClusterSnapshot",
      "secretsmanager:RotateSecret",
      "sns:ConfirmSubscription",
      "sns:Publish",
      "sns:Set*",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sqs:Set*",
      "ssm:Put*",
      "ssm:ResumeSession",
      "ssm:SendCommand",
      "ssm:Start*",
      "ssm:Stop*",
      "ssm:Terminate*",
      "ssm:Update*",
      "sts:DecodeAuthorizationMessage",
      "xray:Put*",
      "xray:Update*",
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceTag/${each.value.application_tag_key}"
      values   = each.value.application_tag_values
    }
  }

  statement {
    sid       = "DenyIAM"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["iam:*"]
  }

  statement {
    sid       = "Tags"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "applicationinsights:TagResource",
      "athena:TagResource",
      "autoscaling:CreateOrUpdateTags",
      "cloud9:TagResource",
      "cloudformation:TagResource",
      "cloudfront:TagResource",
      "cloudwatch:TagResource",
      "dynamodb:TagResource",
      "ec2:CreateTags",
      "ecr:TagResource",
      "eks:TagResource",
      "elasticache:AddTagsToResource",
      "elasticfilesystem:TagResource",
      "events:TagResource",
      "kms:TagResource",
      "lambda:TagResource",
      "logs:TagLogGroup",
      "mq:CreateTags",
      "rds:AddTagsToResource",
      "redshift:CreateTags",
      "secretsmanager:TagResource",
      "sns:TagResource",
      "sqs:TagQueue",
      "ssm:AddTagsToResource",
      "xray:TagResource",
    ]
  }

  statement {
    sid       = "PermissaoDeModificacaoDelecaoParaRecursosSemRestricaoTag"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ssm-guiconnect:CancelConnection",
      "ssm-guiconnect:GetConnection",
      "ssm-guiconnect:StartConnection",
    ]
  }

  statement {
    sid       = "PermissaoDeModificacaoDelecaoParaSqsBaseadoNome"
    effect    = "Allow"
    resources = ["${local.arn_sqs}sqs-${each.value.component_name}-*"]

    actions = [
      "sqs:PurgeQueue",
      "sqs:SendMessage",
    ]
  }

  statement {
    sid       = "PermissaoDeModificacaoDelecaoParaDynamoDbBaseadoNome"
    effect    = "Allow"
    resources = ["${local.arn_dynamodb_table}dynamodb-${each.value.component_name}-*"]

    actions = [
      "dynamodb:Put*",
      "dynamodb:Update*",
      "dynamodb:DeleteItem",
    ]
  }

  statement {
    sid       = "PermissaoDeEscritaParaS3BaseadoNome"
    effect    = "Allow"
    resources = ["${local.arn_s3}s3-${each.value.component_name}-*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
  }

  statement {
    sid           = "DenyActionsS3BaseadoNome"
    effect        = "Deny"
    not_resources = ["${local.arn_s3}s3-${each.value.component_name}-*"]

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
  }

  statement {
    sid       = "EKS"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["eks:AccessKubernetesApi"]
  }

  statement {
    sid       = "DenyEKSDelete"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["eks:Delete*"]
  }

  statement {
    sid       = "SSMDocument"
    effect    = "Allow"
    resources = ["arn:aws:ssm:*:*:document/AWS-StartPortForwardingSession"]
    actions   = ["ssm:StartSession"]
  }
}

data "aws_iam_policy_document" "ro" {
  for_each = var.sso_applications

  statement {
    sid       = "EKS"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["eks:AccessKubernetesApi"]
  }

  statement {
    sid       = "DenyIAM"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["iam:*"]
  }

  statement {
    sid           = "DenyActionsS3BaseadoNome"
    effect        = "Deny"
    not_resources = ["${local.arn_s3}s3-${each.value.component_name}-*"]

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
  }

}