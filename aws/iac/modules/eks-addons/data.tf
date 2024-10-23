data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.worker_iam_role_arn]
    }
  }
}

data "aws_iam_openid_connect_provider" "eks" {
  arn = var.eks_cluster_oidc_provider_arn
}