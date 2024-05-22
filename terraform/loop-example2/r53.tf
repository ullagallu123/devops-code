resource "aws_route53_record" "www" {
  for_each        = var.instance_names
  zone_id         = var.zone_id
  name            = each.key == "frontend" ? "${each.key}.${var.domain_name}" : "${each.key}.${var.domain_name}"
  type            = "A"
  ttl             = 1
  records         = each.key == "frontend" ? [aws_instance.expense[each.key].public_ip] : [aws_instance.expense[each.key].private_ip]
  allow_overwrite = true
}

