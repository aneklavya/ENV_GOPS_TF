terraform {
  backend "s3" {
    bucket = "tfstate-${var.project}-${var.env}-s3"
    key    = "${var.env}/s3/terraform.tfstate"
    region = var.region
  }
}
