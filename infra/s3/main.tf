provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Creator = "Anurag Jha"
      Owner   = "anuragjha"
    }
  }
}

locals {
  s3_name = "${var.project}-${var.env}-${var.bucket_name}"
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = var.ec2_remote_state_bucket
    key    = var.ec2_remote_state_key
    region = var.region
  }
}

resource "aws_s3_bucket" "this" {
  bucket = local.s3_name
  tags = {
    Name = local.s3_name
  }
}

resource "aws_s3_bucket_policy" "allow_ec2_write" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.terraform_remote_state.ec2.outputs.ec2_role_arn
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}
