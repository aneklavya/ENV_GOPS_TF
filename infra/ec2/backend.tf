terraform {
  backend "s3" {
    bucket = "tfstate-myproject-dev-ec2"
    key    = "dev/ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
