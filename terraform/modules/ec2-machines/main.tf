module "bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-${var.bastion_instance_name}"

  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_id
  ami       = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.bastion_instance_name}"
    }
  )
}

module "ansible" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-${var.ansible_instance_name}"

  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.public_subnet_id
  ami       = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.ansible_instance_name}"
    }
  )
}

module "backend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-${var.backend_instance_name}"

  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.private_subnet_id
  ami       = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.backend_instance_name}"
    }
  )
}

module "frontend" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-${var.environment}-${var.frontend_instance_name}"

  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
  # convert StringList to list and get first element
  subnet_id = local.private_subnet_id
  ami       = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.frontend_instance_name}"
    }
  )
}
