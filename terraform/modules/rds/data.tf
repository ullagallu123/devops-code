data "aws_ssm_parameter" "db_subnet_ids" {
  name = "/expense/development/db_subnet_ids"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/expense/development/db_subnet_group_name"
}