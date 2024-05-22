resource "aws_instance" "expense" {
  for_each               = var.instance_names
  ami                    = var.ami
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = var.key_name


  tags = merge(
    var.common_tags,
    {
      Name = each.key
    }
  )
}

resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description


  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
  tags = merge(
    var.common_tags,
    {
      Name = var.sg_name
    }
  )
}
