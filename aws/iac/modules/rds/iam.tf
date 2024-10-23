resource "aws_iam_role" "s3_role" {
  count               = var.s3_role == null && contains(["mssql-ex", "mssql-se", "mssql-web"], var.type) ? 1 : 0
  name                = local.s3_role_name
  description         = "Role para acesso ao bucket de backup/restore do RDS ${local.instance_name}"
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = [var.s3_policy_arn]
  tags = {
    Name = local.s3_role_name
  }
}

resource "aws_iam_role" "role" {
  name = local.role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "monitoring.rds.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
  tags = {
    Name = local.role_name
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}