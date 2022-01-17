resource "aws_lambda_function" "dev_exam_lambda" {
  filename      = "lambda.zip"
  function_name = "${var.resource_prefix}-lambda"
  role          = aws_iam_role.dev_exam_lambda_role.arn
  handler       = "function.lambda_handler"
  runtime       = "python3.9"
  tags          = var.all_tags
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dev_exam_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_images.s3_bucket_arn
}