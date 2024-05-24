variable "peering_required" {
  type = bool
}

variable "acceptor_vpc_id" {
  type = string
  default = ""
}

variable "nat_required" {
  type = bool
}
# Required variables

variable "project_name" {
  type = string
}
variable "environment" {
   type = string
}
variable "vpc_cidr_range" {
   type = string
}
variable "instance_tenancy" {
   type = string
}
variable "public_subnet_cidrs" {
   type = list(string)
  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Please provide exactly 2 valid public subnet CIDRs."
  }
}
variable "db_subnet_cidrs" {
  type = list(string)
  validation {
    condition     = length(var.db_subnet_cidrs) == 2
    error_message = "Please provide exactly 2 valid public subnet CIDRs."
  }
}
variable "private_subnet_cidrs" {
  type = list(string)
  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Please provide exactly 2 valid public subnet CIDRs."
  }
}
variable "common_tags" {
  type = map
  default = {}
}

# Optional variables

variable "vpc_tags" {
  type = map
  default = {}
}
variable "igw_tags" {
  type = map
  default = {}
}
variable "public_rtg_tags" {
  type = map
  default = {}
}
variable "public_subnet_tags" {
  type = map
  default = {}
}
variable "private_subnet_tags" {
  type = map
  default = {}
}
variable "private_rtg_tags" {
  type = map
  default = {}
}
# db subnet variables
variable "db_subnet_tags" {
  type = map
  default = {}
}

variable "db_rtg_tags" {
  type = map
  default = {}
}

variable "eip_tags" {
  type = map
  default = {}
}

variable "nat_tags" {
  type = map
  default = {}
}

variable "peering_tags" {
  type = map
  default = {}
}
variable "db_group_tags" {
  type = map
  default = {}
}