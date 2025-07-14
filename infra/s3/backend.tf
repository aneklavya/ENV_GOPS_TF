terraform {
  backend "s3" {
    bucket = "tfstate-myproject-dev-s3"
    key    = "dev/s3/terraform.tfstate"
    region = "us-east-1"
  }
}
