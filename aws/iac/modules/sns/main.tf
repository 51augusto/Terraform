resource "aws_sns_topic" "this" {
  name                        = local.topic_name
  kms_master_key_id           = var.kms_key != null ? var.kms_key : "alias/aws/sns"
  fifo_topic                  = var.fifo
  content_based_deduplication = var.fifo ? var.content_based_deduplication : false
  delivery_policy             = local.delivery_policy
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = local.topic_policy
}