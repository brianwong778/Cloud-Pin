resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "index.html" # First page to serve

  origin {
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id                = "s3-origin"                                 # Internal name that Cloudfront uses
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id # Attaches to OAC
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"
  }
  # -----------------------------
  # Hosted Zone Lookup
  # -----------------------------
  data "aws_route53_zone" "primary" {
    name         = var.domain_name
    private_zone = false
  }

  # Since this is just a static page: 
  allowed_methods = ["GET", "HEAD"]
  cached_methods  = ["GET", "HEAD"]

  compress = true

  cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # AWS Managed: CachingOptimized


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.brianprojects.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Project = "cloud-pin-1"
  }

}

