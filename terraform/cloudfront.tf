resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "finalBoard.html" # First page to serve

  origin {
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id                = "s3-origin"                                 # Internal name that Cloudfront uses
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id # Attaches to OAC
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    # Since this is just a static page: 
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

  }



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
