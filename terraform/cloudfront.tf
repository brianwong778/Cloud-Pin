resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "Index.html"
}