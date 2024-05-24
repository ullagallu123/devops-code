module "db" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "db"
  sg_description = "This sg used for mysql 3306 db port only"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true"
    "Developer"   = "sivaramakrishna"
  }
}

module "backend" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "backend"
  sg_description = "This sg used for backend"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true"
    "Developer"   = "sivaramakrishna"
  }
}

module "frontend" {
  source         = "../../sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "frontend"
  sg_description = "This sg used for frontend"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value

  common_tags = {
    "Project"     = "${var.project_name}",
    "Environment" = "${var.environment}",
    "Terraform"   = "true"
    "Developer"   = "sivaramakrishna"
  }
}

resource "aws_security_group_rule" "db_rule" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.backend.sg_id
  security_group_id = module.db.sg_id
}

resource "aws_security_group_rule" "backend_rule" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.frontend.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "frontend_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}