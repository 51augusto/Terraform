resource "aws_iam_policy" "cicd_policy" {
  count       = var.create_cicd_policy ? 1 : 0
  name        = local.cicd_policy_name
  description = "Política para acesso ao cluster pelos jobs de CI/CD."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecs:UpdateService",
          "ecs:DescribeServices"
        ],
        "Resource" : [for k, v in module.service : v.service.id]
      },
      {
        "Action" : "iam:PassRole",
        "Effect" : "Allow",
        "Resource" : concat(
          [for k, v in module.service : v.execution_role.arn],
          [for k, v in var.services : v.role_arn]
        )
        "Condition" : {
          "StringLike" : {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}