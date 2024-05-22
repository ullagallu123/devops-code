output "record_names" {
  value = aws_route53_record.www.*.name
}

output "record_ips" {
  value = aws_route53_record.www.*.records
}

output "instance_public_ips" {
  value = aws_instance.expense.*.public_ip
}