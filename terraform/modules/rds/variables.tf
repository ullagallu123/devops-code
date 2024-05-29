variable "profile" {
  default = "nv"
}

variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "development"
}

variable "common_tags" {
  default = {
    "Terraform"   = "true"
    "Environment" = "development"
    "Developer"   = "sivaramakrishna"
    "Project"     = "expense"
  }
}

variable "zone_name" {
  default = "ullagallubuffellomilk.store"
}