# -----------------------------
# ACM Certificate (us-east-1)
# -----------------------------
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "brianprojects" {
  provider          = aws.us_east_1
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [
    var.domain_name
  ]

  tags = {
    Project = "cloud-pin-1"
  }
}

# -----------------------------
# DNS Validation Records
# -----------------------------
resource "aws_route53_record" "brianprojects_validation" {
  for_each = {
    for dvo in aws_acm_certificate.brianprojects.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]

}

# -----------------------------
# Certificate Validation
# -----------------------------
resource "aws_acm_certificate_validation" "brianprojects" {
  provider        = aws.us_east_1
  certificate_arn = aws_acm_certificate.brianprojects.arn
  validation_record_fqdns = [
    for record in aws_route53_record.brianprojects_validation :
    record.fqdn
  ]
}
