resource "aws_sesv2_email_identity" "domain" {
  email_identity = "verityprocessservice.com"
}

resource "aws_route53_record" "ses_dkim" {
  count   = 3
  zone_id = aws_route53_zone.main.zone_id
  name    = "${aws_sesv2_email_identity.domain.dkim_signing_attributes[0].tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = 600
  records = ["${aws_sesv2_email_identity.domain.dkim_signing_attributes[0].tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "verityprocessservice.com"
  type    = "MX"
  ttl     = 3600
  records = ["10 mx1.improvmx.com", "20 mx2.improvmx.com"]
}

resource "aws_route53_record" "spf" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "verityprocessservice.com"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:spf.improvmx.com include:amazonses.com ~all"]
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "_dmarc.verityprocessservice.com"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=none; rua=mailto:serve@verityprocessservice.com"]
}