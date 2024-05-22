output "record_names" {
  value = [for n in aws_route53_record.www : n.name]
}

output "record_ips" {
  value = [for r in aws_route53_record.www : r.records]
}

output "instance_public_ips" {
  value = [for pubip in aws_instance.expense : pubip.public_ip]
}