project_name = "expense"
environment  = "dev"

vpc_cidr_range   = "10.1.0.0/16"
instance_tenancy = "default"

common_tags = {
  "Project_Name" = "Expense"
  "Environment"  = "Development"
  "Developer"    = "sivaramakrishna"
  "Terraform"    = "True"
}

public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.11.0/24", "10.1.12.0/24"]
db_subnet_cidrs      = ["10.1.21.0/24", "10.1.22.0/24"]

peering_required = false
nat_required     = false

