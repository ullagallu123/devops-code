output "vpc_id" {
  value = module.expense-vpc.vpc_id
}

output "public_subnet_id" {
  value = module.expense-vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.expense-vpc.private_subnet_id
}

output "db_subnet_id" {
  value = module.expense-vpc.db_subnet_id
}

output "aws_db_subnet_group_id" {
  value = module.expense-vpc.db_subnet_group_id
}