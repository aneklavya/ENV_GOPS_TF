variable "env" { description = "Environment name" }
variable "project" { description = "Project name" }
variable "bucket_name" { description = "S3 bucket name" }
variable "region" { description = "AWS region" }
variable "ec2_remote_state_bucket" { description = "EC2 tfstate bucket" }
variable "ec2_remote_state_key" { description = "EC2 tfstate key" }
