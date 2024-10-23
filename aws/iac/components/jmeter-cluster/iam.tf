resource "aws_iam_policy" "jmeter_describe_instance" {
  provider    = aws.use1
  name        = "policy-ec2-${module.this_use1.custom_context_id}-jmeter-describe-instance"
  path        = "/"
  description = "Política para permitir acesso às informações de instância para funcionamento do script de inicialização do JMeter Server"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "ec2:DescribeInstances",
        "Resource" : "*",
      }
    ]
  })
}

resource "aws_iam_policy" "jmeter_get_pkg" {
  provider    = aws.use1
  name        = "policy-ec2-${module.this_use1.custom_context_id}-jmeter-get-pkg"
  path        = "/"
  description = "Política para permitir acesso ao pacote do JMeter no bucket do SSM"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::s3-internal-shared-use1-ssm-resources/jmeter/apache-jmeter-5.4.3.tgz",
      }
    ]
  })
}