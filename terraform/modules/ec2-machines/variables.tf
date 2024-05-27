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

variable "instance_name" {
  default = "bastion"
}

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "development"
    Terraform   = "true"
    developer   = "sivaramakrishna"
  }
}
