resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "finalBoard.html" # First page to serve
  aliases             = ["cloudpin.${var.domain_name}"]

  origin {
    domain_name              = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id                = "s3-origin"                                 # Internal name that Cloudfront uses
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id # Attaches to OAC
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03"
    origin_request_policy_id   = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"
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
