output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = aws_route53_zone.default.zone_id
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = aws_route53_zone.default.name_servers
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = aws_route53_zone.default.name
}

output "route53_zone_arn" {
  description = "ARN of Route53 zone"
  value       = aws_route53_zone.default.arn
}
