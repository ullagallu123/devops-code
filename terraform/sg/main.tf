resource "aws_security_group" "allow_tls" {
  name        = local.sg_name
  description = var.sg_description
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingree_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"] # ingress.value[key-name]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"] # ingress.value[key-name]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
      Name = var.sg_name
    }
  )
}


