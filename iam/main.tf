resource "aws_iam_user_policy" "terraform_user_policy" {
  name = "terraform-admin-policy"
  user = var.iam_user_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
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
}
