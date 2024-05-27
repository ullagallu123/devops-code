# DB SG
module "db" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.db_sg_name
  sg_description = "This SG is used for MySQL 3306 DB port only"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true",
    "Developer"   = "sivaramakrishna"
  }
}

# Backend SG
module "backend" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.backend_sg_name
  sg_description = "This SG is used for backend services"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true",
    "Developer"   = "sivaramakrishna"
  }
}

# Frontend SG
module "frontend" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.frontend_sg_name
  sg_description = "This SG is used for frontend services"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true",
    "Developer"   = "sivaramakrishna"
  }
}

# Ansible SG
module "ansible" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.ansible_sg_name
  sg_description = "This SG is used for ansible"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true",
    "Developer"   = "sivaramakrishna"
  }
}

# Bastion SG
module "bastion" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.bastion_sg_name
  sg_description = "This SG is used for bastion"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true",
    "Developer"   = "sivaramakrishna"
  }
}

# DB Rules
resource "aws_security_group_rule" "db_backend_mysql" {
  description              = "DB accepting connections from backend"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

resource "aws_security_group_rule" "db_bastion_mysql" {
  description              = "Allow traffic from bastion to DB"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}

# Backend Rules
resource "aws_security_group_rule" "backend_frontend_http" {
  description              = "Backend accepting HTTP from frontend"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_bastion_ssh" {
  description              = "Backend accepting SSH from bastion"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_ansible_ssh" {
  description              = "Backend accepting SSH from ansible"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible.sg_id
  security_group_id        = module.backend.sg_id
}

# Frontend Rules
resource "aws_security_group_rule" "frontend_http" {
  description       = "Frontend accepting HTTP from internet"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_bastion_ssh" {
  description              = "Allow SSH traffic from bastion to frontend"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_ansible_ssh" {
  description              = "Allow SSH traffic from ansible to frontend"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible.sg_id
  security_group_id        = module.frontend.sg_id
}

# Ansible Rules
resource "aws_security_group_rule" "ansible_rule_ssh" {
  description       = "Allow SSH traffic from internet to ansible"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible.sg_id
}

# Bastion Rules
resource "aws_security_group_rule" "bastion_rule_ssh" {
  description       = "Allow SSH traffic from internet to bastion"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}
