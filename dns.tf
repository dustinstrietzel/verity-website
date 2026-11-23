resource "aws_route53_zone" "main" {
  name = "verityprocessservice.com"
}

output "name_servers" {
  description = "Put these four into Porkbun"
  value       = aws_route53_zone.main.name_servers
}

locals {
  site_names = ["verityprocessservice.com", "www.verityprocessservice.com"]
}

resource "aws_route53_record" "site_ipv4" {
  for_each = toset(local.site_names)

  zone_id = aws_route53_zone.main.zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "site_ipv6" {
  for_each = toset(local.site_names)

  zone_id = aws_route53_zone.main.zone_id
  name    = each.value
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}