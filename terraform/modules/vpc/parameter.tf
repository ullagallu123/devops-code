resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc-id"
  type  = "String"
  value = module.expense-vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/public-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.public_subnet_id)
}

resource "aws_ssm_parameter" "private_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/private-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.private_subnet_id)
}

resource "aws_ssm_parameter" "db_subnet_id" {
  name  = "/${var.project_name}/${var.environment}/db-subnet-ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.db_subnet_id)
}

resource "aws_ssm_parameter" "db_group_name" {
  name  = "/${var.project_name}/${var.environment}/db-group-name"
  type  = "String"
  value = module.expense-vpc.db_group_name
}
