variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "site_bucket_name" {
  description = "Name of the S3 bucket that will host the static site"
  type        = string
}

variable "domain_name" {
  description = "my personal domain name"
  type        = string
  default     = "brianprojects.com"
}

