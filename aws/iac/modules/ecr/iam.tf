resource "aws_iam_policy" "pull_policy" {
  count       = var.create_pull_policy ? 1 : 0
  name        = local.pull_policy_name
  description = "Política para pull de imagens do repositório."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowECRLogin",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowECRPull",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        "Resource" : aws_ecr_repository.ecr_repo.arn
      }
    ]
  })
}
