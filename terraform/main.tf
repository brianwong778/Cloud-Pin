terraform {
  backend "s3" {
    bucket = "cloud-pin-terraform-state-bucket-1-812751451795-us-east-1-an"
    key    = "static-site/terraform.tfstate"
    region = "us-east-1"
  }
}