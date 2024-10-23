resource "aws_iam_policy" "cicd_policy" {
  count       = var.create_cicd_policy ? 1 : 0
  name        = local.cicd_policy_name
  description = "Política para acesso ao S3 e ao CloudFront pelos jobs de CI/CD."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowS3",
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${module.bucket.bucket.id}",
          "arn:aws:s3:::${module.bucket.bucket.id}/*"
        ]
      },
      {
        "Sid" : "AllowCloudFront",
        "Effect" : "Allow",
        "Action" : [
          "cloudfront:GetInvalidation",
          "cloudfront:CreateInvalidation",
          "cloudfront:GetDistributionConfig",
          "cloudfront:UpdateDistribution"
        ],
        "Resource" : module.website.cloudfront_distribution_arn
      }
    ]
  })
}
