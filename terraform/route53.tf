# -----------------------------
# Hosted Zone Lookup
# -----------------------------
data "aws_route53_zone" "primary" {
  name         = var.domain_name
  private_zone = false
}

# -----------------------------
# Subdomain -> CloudFront Alias
# -----------------------------
resource "aws_route53_record" "cloudpin_alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "cloudpin.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }

}
