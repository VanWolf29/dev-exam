module "backend" {
  source = "../modules/s3_backend"

  dynamodb_table_name = "dev-exam-raul-lock-table"
  s3_acl              = "private"
  s3_backend_folder   = "dev-exam/"
  s3_name             = "dev-exam-raul-tfstate"
  tags             = {
    DEV_EXAM = "Raul Rivera"
  }
}