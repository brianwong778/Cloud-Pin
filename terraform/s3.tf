resource "aws_s3_bucket" "site"{
    bucket = var.site_bucket_name
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Project = "cloud-pin-1"
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.site_bucket_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

  tags = {
    Project = "cloud-pin-1"
  }
}
