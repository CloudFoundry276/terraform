####################################################################################################
# Date: 12/25/2023
# Author: Sagar Pitalekar
# Title: Terraform Remote Backend with AWS S3
# Description: In this lab, we demonstrate how to store terraform state file (tfstate) into s3 
#              bucket & dynamodb table.
####################################################################################################

# create s3 bucket
resource "aws_s3_bucket" "labdts04s3bucket" {
  bucket = "labdts04s3bucket"
  force_destroy = true
}

# enable versioning for s3 bucket
resource "aws_s3_bucket_versioning" "labdts04s3bucketversion" {
  bucket = aws_s3_bucket.labdts04s3bucket.id
  versioning_configuration {
    status = "enabled"
  }
}

# enable default server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "labdts04s3bucketencryption" {
  bucket = aws_s3_bucket.labdts04s3bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# block all explicit access to s3 bucket
resource "aws_s3_bucket_public_access_block" "labdts04s3bucketblockaccess" {
  bucket = aws_s3_bucket.labdts04s3bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# dynamodb table
resource "aws_dynamodb_table" "labdts04s3buckettbl" {
  name = "labdts04s3buckettbl"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}