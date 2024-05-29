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
  #user_data = file("ansible.sh")
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
  subnet_id = local.public_subnet_id
  ami       = data.aws_ami.ami_info.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.frontend_instance_name}"
    }
  )
}


### creating zone records zone records
module "bastion_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name
  records = [
    {
      name = "bastion"
      type = "A"
      ttl  = 1
      records = [
        module.bastion.public_ip
      ]
    }
  ]
}

module "frontend_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name
  records = [
    {
      name = "frontend"
      type = "A"
      ttl  = 1
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name = ""
      type = "A"
      ttl  = 1
      records = [
        module.frontend.public_ip
      ]
    }
  ]
}

module "backend_record" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  version   = "~> 2.0"
  zone_name = var.zone_name
  records = [
    {
      name = "backend"
      type = "A"
      ttl  = 1
      records = [
        module.backend.private_ip
      ]
    }
  ]
}

module "ansible_record" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name
  records = [
    {
      name = "ansible1"
      type = "A"
      ttl  = 1
      records = [
        module.ansible.public_ip
      ]
    }
  ]
}