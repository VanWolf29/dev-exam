variable "resource_prefix" {
  description = "Prefix for all resources created in AWS"
  type        = string
  default     = "dev-exam-raul"
}

variable "all_tags" {
  description = "Tag for all resources in TF"
  type        = map(string)
  default     = {
    DEV_EXAM = "Raul Rivera"
  }
}