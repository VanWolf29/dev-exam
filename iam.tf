data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid     = "DynamoDbPermissions"
    effect  = "Allow" 
    actions = [
      "dynamodb:Batch*",
      "dynamodb:Get*",
      "dynamodb:PutItem"
    ]
    resources = [
      module.dev_exam_dynamodb_table.dynamodb_table_arn
    ]
  }

  depends_on = [
    module.dev_exam_dynamodb_table
  ]
}

resource "aws_iam_policy" "dev_exam_lambda_policy" {
  name        = "${var.resource_prefix}"
  description = "Role for lambda to access S3 and DynamoDB"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role" "dev_exam_lambda_role" {
  name = "${var.resource_prefix}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.dev_exam_lambda_role.name
  policy_arn = aws_iam_policy.dev_exam_lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "basic_execution_role" {
  role       = aws_iam_role.dev_exam_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}