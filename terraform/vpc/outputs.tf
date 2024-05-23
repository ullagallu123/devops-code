output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = [for az, public_subnet_ids in aws_subnet.public : public_subnet_ids.id]
}

output "private_subnet_id" {
  value = [for private_subnet_ids in aws_subnet.private : private_subnet_ids.id]
}

output "db_subnet_id" {
  value = [for db_subnet_ids in aws_subnet.db : db_subnet_ids.id]
}