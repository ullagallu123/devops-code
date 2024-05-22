resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}


variable "zone_id" {
  default = ""
}