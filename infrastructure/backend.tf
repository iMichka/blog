terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket       = "blog-tofu-state"
    key          = "state/terraform.tfstate"
    region       = "eu-west-3"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"

  default_tags {
    tags = {
      ManagedBy = "Managed by OpenTofu"
    }
  }
}

# ----------------------------
# Provider for us east 1 region, for acm certificates
# ----------------------------

provider "aws" {
  alias      = "cloudfront-acm-us-east-1"
  region     = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "Managed by OpenTofu"
    }
  }
}

# ----------------------------
# OpenTofu remote state bucket
# ----------------------------

resource "aws_s3_bucket" "tofu_state" {
  bucket = "blog-tofu-state"
}

resource "aws_s3_bucket_versioning" "tofu_state" {
  bucket = aws_s3_bucket.tofu_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tofu_state" {
  bucket = aws_s3_bucket.tofu_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tofu_state" {
  bucket = aws_s3_bucket.tofu_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
