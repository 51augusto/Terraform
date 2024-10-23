resource "aws_sqs_queue" "queue" {
  name                        = local.queue_name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.content_based_deduplication
  delay_seconds               = var.delay_seconds
  max_message_size            = var.max_message_size
  message_retention_seconds   = var.message_retention_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  redrive_policy              = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dlq.arn}\",\"maxReceiveCount\":${var.max_receive_count}}"
  tags = {
    Name = local.queue_name
  }
}

resource "aws_sqs_queue" "dlq" {
  name                        = local.dlq_name
  fifo_queue                  = var.fifo
  content_based_deduplication = var.content_based_deduplication
  max_message_size            = var.max_message_size
  message_retention_seconds   = var.dlq_message_retention_seconds
  visibility_timeout_seconds  = var.dlq_visibility_timeout_seconds
  tags = {
    Name = local.dlq_name
  }
}