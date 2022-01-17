module "dev_exam_dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "1.1.1"

  #create_table = false

  name           = "${var.resource_prefix}-table"
  hash_key       = "ID"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 2

  autoscaling_read = {
    scale_in_cooldown  = 50
    scale_out_cooldown = 40
    target_value       = 50
    max_capacity       = 5
  }

  autoscaling_write = {
    scale_in_cooldown  = 50
    scale_out_cooldown = 40
    target_value       = 70
    max_capacity       = 10
  }

  attributes = [
    {
      name = "ID"
      type = "S"
    }
  ]

  tags = var.all_tags
} 