# locals {
#   name    = each.value == "frontend" ? "${each.value}.${var.domain_name}" : "${each.value}.${var.domain_name}"
#   records = each.value == "frontend" ? [aws_instance.expense[each.value].public_ip] : [aws_instance.expense[each.value].private_ip]
# }