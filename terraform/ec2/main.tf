resource "aws_instance" "instance_names" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_id
  key_name               = var.key_name
  tags = merge(
    var.common_tags,
    {
      Name = var.instance_name
    }
  )
}

