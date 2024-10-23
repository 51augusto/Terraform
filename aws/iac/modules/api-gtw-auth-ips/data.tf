data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "apigateway_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "archive_file" "lambda_package" {
  type             = "zip"
  output_file_mode = "0644"
  source_file      = "${path.module}/function_code/lambda_function.py"
  output_path      = "${path.module}/function_code/lambda_function.zip"
}