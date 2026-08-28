variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "site_bucket_name" {
  type = string
}

variable "domain_name" {
  type    = string
  default = null
}
