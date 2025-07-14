provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Creator = "Anurag Jha"
      Owner   = "anuragjha"
    }
  }
}

# Create IAM Role for Terraform operations
resource "aws_iam_role" "terraform_admin_role" {
  name = "terraform-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::702865854817:user/anuragjha"
        }
      }
    ]
  })

  tags = {
    Name    = "terraform-admin-role"
    Creator = "Anurag Jha"
    Owner   = "anuragjha"
  }
}

# Create IAM Policy with required permissions
resource "aws_iam_policy" "terraform_admin_policy" {
  name        = "terraform-admin-policy"
  description = "Policy for Terraform administrative operations"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "s3:*",
          "iam:*",
          "sts:*",
          "cloudwatch:*",
          "logs:*",
          "dynamodb:*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name    = "terraform-admin-policy"
    Creator = "Anurag Jha"
    Owner   = "anuragjha"
  }
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "terraform_admin_attachment" {
  role       = aws_iam_role.terraform_admin_role.name
  policy_arn = aws_iam_policy.terraform_admin_policy.arn
}
