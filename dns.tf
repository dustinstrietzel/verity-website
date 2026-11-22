resource "aws_route53_zone" "main" {
  name = "verityprocessservice.com"
}

output "name_servers" {
  description = "Put these four into Porkbun"
  value       = aws_route53_zone.main.name_servers
}
