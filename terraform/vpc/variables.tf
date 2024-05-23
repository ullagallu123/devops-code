variable "profile" {
  default = "nv"
}
variable "region" {
  default = "us-east-1"
}

variable "peering_required" {
  default = false
}

variable "acceptor_vpc_id" {
  default = ""
}

variable "nat_required" {
  default = false
}
# Required variables

variable "project_name" {}
variable "environment" {}
variable "vpc_cidr_range" {}
variable "instance_tenancy" {}
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
  default = {}
}

# Optional variables

variable "vpc_tags" {
  default = {}
}
variable "igw_tags" {
  default = {}
}
variable "public_rtg_tags" {
  default = {}
}
variable "public_subnet_tags" {
  default = {}
}
variable "private_subnet_tags" {
  default = {}
}
variable "private_rtg_tags" {
  default = {}
}
# db subnet variables
variable "db_subnet_tags" {
  default = {}
}

variable "db_rtg_tags" {
  default = {}
}

variable "eip_tags" {
  default = {}
}

variable "nat_tags" {
  default = {}
}

variable "peering_vpc_id" {
  default = ""
}

variable "peering_tags" {
  default = {}
}