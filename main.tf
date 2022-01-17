module "s3_web_app" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.12.0"

  bucket        = "${var.resource_prefix}-webapp-bucket"
  acl           = "private"
  force_destroy = true

  tags = var.all_tags

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

module "s3_images" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.12.0"

  bucket = "${var.resource_prefix}-images-bucket"

  tags = var.all_tags
}

resource "aws_s3_bucket_object" "s3_images_folder" {
  bucket = module.s3_images.s3_bucket_id
  key    = "images/"

  depends_on = [module.s3_images]
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_images.s3_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.dev_exam_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "images/"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
