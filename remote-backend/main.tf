provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name                        = "infra-tfstate"
  read_capacity               = 1
  write_capacity              = 1
  hash_key                    = "LockID"
  deletion_protection_enabled = false

  attribute {
    name = "LockID"
    type = "S"
  }
}