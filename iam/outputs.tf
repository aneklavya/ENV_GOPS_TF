output "terraform_admin_role_arn" {
  description = "ARN of the Terraform admin role"
  value       = aws_iam_role.terraform_admin_role.arn
}

output "terraform_admin_role_name" {
  description = "Name of the Terraform admin role"
  value       = aws_iam_role.terraform_admin_role.name
}
