resource "aws_cloudwatch_log_group" "log_group_index_slow" {
  name              = local.log_group_index_slow
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_index_slow
  }
}

resource "aws_cloudwatch_log_group" "log_group_search_slow" {
  name              = local.log_group_search_slow
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_search_slow
  }
}

resource "aws_cloudwatch_log_group" "log_group_es_application" {
  name              = local.log_group_es_application
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_es_application
  }
}

resource "aws_cloudwatch_log_group" "log_group_audit" {
  name              = local.log_group_audit
  retention_in_days = var.logging_retention

  tags = {
    Name = local.log_group_audit
  }
}

resource "aws_cloudwatch_log_resource_policy" "log_resource_policy" {
  policy_name = local.log_policy_name

  policy_document = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "es.amazonaws.com"
        },
        "Action" : [
          "logs:PutLogEvents",
          "logs:PutLogEventsBatch",
          "logs:CreateLogStream"
        ],
        "Resource" : [
          "${aws_cloudwatch_log_group.log_group_index_slow.arn}:*",
          "${aws_cloudwatch_log_group.log_group_search_slow.arn}:*",
          "${aws_cloudwatch_log_group.log_group_es_application.arn}:*",
          "${aws_cloudwatch_log_group.log_group_audit.arn}:*"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : data.aws_caller_identity.current.account_id
          },
          "ArnLike" : {
            "aws:SourceArn" : "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.domain_name}"
          }
        }
      }
    ]
  })
}