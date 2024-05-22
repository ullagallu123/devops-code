resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description

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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.common_tags,
    {
      Name = var.sg_name
    }
  )
}


