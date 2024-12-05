terraform {
  backend "s3" {
    bucket = "backend-s3-tf-bucket-pankaj"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

# Create an S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucketndlknalsf-test"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# # Outputs
# output "s3_bucket_name" {
#   description = "The name of the created S3 bucket"
#   value       = aws_s3_bucket.example.bucket
# }
