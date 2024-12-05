terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = var.backend_bucket_name
    key            = var.backend_key
    region         = var.backend_region
    # encrypt        = true
    # dynamodb_table = var.dynamodb_table_name
  }
}
provider "aws" {
  region = var.aws_region
}
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_tag_name
    Environment = var.bucket_environment
  }
}

# Example DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = var.dynamodb_table_name
  # billing_mode   = "PAY_PER_REQUEST"
  # hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.bucket_environment
  }
}
# Backend Configuration
variable "backend_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "my-terraform-state"
}

variable "backend_key" {
  description = "Key for the Terraform state file"
  type        = string
  default     = "terraform/state"
}

variable "backend_region" {
  description = "AWS region for the backend S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-locks"
}

# AWS Provider Configuration
variable "aws_region" {
  description = "AWS region for provider configuration"
  type        = string
  default     = "us-east-1"
}

# S3 Bucket Resource Configuration
variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
  default     = "my-tf-test-bucket"
}

variable "bucket_tag_name" {
  description = "Tag name for the S3 bucket"
  type        = string
  default     = "My bucket"
}

variable "bucket_environment" {
  description = "Environment tag for the S3 bucket"
  type        = string
  default     = "Dev"
}
output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "dynamodb_table_name" {
  description = "The name of the created DynamoDB table"
  value       = aws_dynamodb_table.terraform_locks.name
}
