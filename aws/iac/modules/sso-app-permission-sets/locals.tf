locals {
  instance_arn      = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  account_ids = {
    workload-dev = "880974337725"
    workload-cer = "849598278174"
    workload-hml = "241290613667"
    workload-prd = "899836677866"
  }

  arn_prefix          = "arn:aws:"
  arn_regional_suffix = ":*:*:"
  arn_sqs             = "${local.arn_prefix}sqs${local.arn_regional_suffix}"
  arn_dynamodb        = "${local.arn_prefix}dynamodb${local.arn_regional_suffix}"
  arn_dynamodb_table  = "${local.arn_dynamodb}table/"
  arn_s3              = "${local.arn_prefix}s3:::"

}