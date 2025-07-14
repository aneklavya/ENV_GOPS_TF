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
  ec2_name = "${var.project}-${var.env}-${var.instance_name}"
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${local.ec2_name}-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

data "aws_iam_policy_document" "ec2_s3_write" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_role_policy" "ec2_s3_write_policy" {
  name   = "${local.ec2_name}-s3-write"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_s3_write.json
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.ec2_name}-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "this" {
  ami                  = "ami-0c02fb55956c7d316"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = local.ec2_name
  }
}
