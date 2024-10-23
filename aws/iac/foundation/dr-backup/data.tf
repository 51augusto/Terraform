data "aws_iam_policy_document" "netbackup_policy" {
  provider = aws.use1
  statement {
    actions = ["s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:GetObjectAttributes",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionAttributes",
      "s3:PutObject",
      "s3:DeleteObject",
    "s3:DeleteObjectVersion"]
    resources = [module.s3_netbackup.bucket.arn,
    "${module.s3_netbackup.bucket.arn}/*"]
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-network-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-network-use1-tfstate"
    region         = "us-east-1"
    profile        = "network"
  }
}

data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-shared-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-shared-use1-tfstate"
    region         = "us-east-1"
    profile        = "shared-services"
  }
}
