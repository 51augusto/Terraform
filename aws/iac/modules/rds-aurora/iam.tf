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