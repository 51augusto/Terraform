resource "aws_s3_bucket" "flow_log_bucket" {
  provider = aws.use1
  bucket   = "s3-internal-prd-use1-flow-logs"
}

resource "aws_flow_log" "flow_log_use1" {
  provider             = aws.use1
  log_destination      = aws_s3_bucket.flow_log_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "REJECT"
  vpc_id               = module.vpc_use1.vpc_id
}

resource "aws_flow_log" "flow_log_sae1" {
  provider             = aws.sae1
  log_destination      = aws_s3_bucket.flow_log_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "REJECT"
  vpc_id               = module.vpc_sae1.vpc_id
}