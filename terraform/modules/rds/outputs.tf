# output "end_point" {
#   value = module.db.db_instance_endpoint
# }
output "db_subnet_ids" {
  value = data.aws_ssm_parameter.db_subnet_ids.value
}

output "db_subnet_group_name" {
  value = data.aws_ssm_parameter.db_subnet_group_name.value
}
