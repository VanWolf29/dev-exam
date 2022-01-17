terraform {
  backend "s3" {
    bucket         = "dev-exam-raul-tfstate"
    key            = "dev-exam/"
    region         = "us-east-1"
    dynamodb_table = "dev-exam-raul-lock-table"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
