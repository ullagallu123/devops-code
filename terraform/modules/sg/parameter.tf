resource "aws_ssm_parameter" "db_sg_id" {
  name  = "/${var.project_name}/${var.environment}/db-sg-id"
  type  = "String"
  value = module.db.sg_id
}

resource "aws_ssm_parameter" "backend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/backend-sg-id"
  type  = "String"
  value = module.backend.sg_id
}

resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend-sg-id"
  type  = "String"
  value = module.frontend.sg_id
}

resource "aws_ssm_parameter" "ansible_sg_id" {
  name  = "/${var.project_name}/${var.environment}/ansible-sg-id"
  type  = "String"
  value = module.ansible.sg_id
}
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion-sg-id"
  type  = "String"
  value = module.bastion.sg_id
}