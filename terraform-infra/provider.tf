terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
 
}

provider "aws" {
  region = "us-east-1"
}

# Create an S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucketndlknalsf"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Outputs
output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.example.bucket
}
