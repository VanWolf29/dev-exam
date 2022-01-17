output "website_endpoint" {
  description = "S3 website endpoint"
  value       = "http://${module.s3_web_app.s3_bucket_website_endpoint}"
}