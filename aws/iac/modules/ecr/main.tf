resource "aws_ecr_repository" "ecr_repo" {
  name = local.ecr_name
  tags = {
    Name = local.ecr_name
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repo.name
  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Expire untagged images older than 1 day",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : {
          "type" : "expire"
        }
      },
      {
        "rulePriority" : 2,
        "description" : "Keep maximum of ${var.max_release_tags} release tags",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : var.release_tag_prefixes,
          "countType" : "imageCountMoreThan",
          "countNumber" : var.max_release_tags
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository_policy" "policy" {
  count      = var.read_principal != null ? 1 : 0
  repository = aws_ecr_repository.ecr_repo.name
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPull",
        "Effect" : "Allow",
        "Principal" : var.read_principal,
        "Action" : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}