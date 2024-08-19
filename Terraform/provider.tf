terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  #after the first initializtion i initilized remote backend in s3 bucket to ensure resilience of the state file 
  backend "s3" {
    bucket = "terraform-backend-bucket-moveo"
    key    = "dev/terraform.tfstate"
    region = "eu-north-1"
  }
}


resource "aws_s3_bucket" "terraform_state" {
  bucket        = "terraform-backend-bucket-moveo"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
#state locking so there wont be any chance for 2 or more write to the bucket at the same time
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  region = "eu-north-1"
}