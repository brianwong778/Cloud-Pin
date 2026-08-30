terraform {
  backend "s3" {
    bucket = "cloud-pin-terraform-state-bucket-1"
    key    = "static-site/terraform.tfstate"
    region = "us-east-1"
  }
}