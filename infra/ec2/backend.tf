terraform {
  backend "s3" {
    bucket = "tfstate-${var.project}-${var.env}-ec2"
    key    = "${var.env}/ec2/terraform.tfstate"
    region = var.region
  }
}
