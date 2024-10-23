resource "aws_iam_role" "sae1_session_manager_role" {
  provider = aws.sae1
  name     = local.iam_sae1_session_manager_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  tags = {
    Name = local.iam_sae1_session_manager_role
  }
}

resource "aws_iam_instance_profile" "sae1_session_manager_profile" {
  provider = aws.sae1
  name     = local.iam_sae1_session_manager_profile
  role     = aws_iam_role.sae1_session_manager_role.name
  tags = {
    Name = local.iam_sae1_session_manager_profile
  }
}

resource "aws_iam_role" "use1_session_manager_role" {
  provider = aws.use1
  name     = local.iam_use1_session_manager_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  tags = {
    Name = local.iam_use1_session_manager_role
  }
}

resource "aws_iam_instance_profile" "use1_session_manager_profile" {
  provider = aws.use1
  name     = local.iam_use1_session_manager_profile
  role     = aws_iam_role.use1_session_manager_role.name
  tags = {
    Name = local.iam_use1_session_manager_profile
  }
}

resource "aws_iam_role" "grafana_role" {
  provider = aws.use1
  name     = local.iam_grafana_role
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::788006387775:role/service-role/AmazonGrafanaServiceRole-ZDWK4Wjs8"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = local.iam_grafana_role
  }
}

resource "aws_iam_policy" "grafana_policy" {
  provider    = aws.use1
  name        = local.iam_grafana_policy
  description = "Política para acesso do Grafana às métricas do Cloudwatch"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowReadingMetricsFromCloudWatch",
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetInsightRuleReport"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowReadingLogsFromCloudWatch",
        "Effect" : "Allow",
        "Action" : [
          "logs:DescribeLogGroups",
          "logs:GetLogGroupFields",
          "logs:StartQuery",
          "logs:StopQuery",
          "logs:GetQueryResults",
          "logs:GetLogEvents"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowReadingTagsInstancesRegionsFromEC2",
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeTags",
          "ec2:DescribeInstances",
          "ec2:DescribeRegions"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowReadingResourcesForTags",
        "Effect" : "Allow",
        "Action" : "tag:GetResources",
        "Resource" : "*"
      }
    ]
  })
  tags = {
    Name = local.iam_grafana_policy
  }
}

resource "aws_iam_role_policy_attachment" "grafana_role_attachment" {
  provider   = aws.use1
  role       = aws_iam_role.grafana_role.name
  policy_arn = aws_iam_policy.grafana_policy.arn
}