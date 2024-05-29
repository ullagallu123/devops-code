variable "profile" {
  default = "nv"
}

variable "region" {
  default = "us-east-1"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "development"
}

variable "bastion_instance_name" {
  default = "bastion"
}
variable "ansible_instance_name" {
  default = "ansible"
}
variable "frontend_instance_name" {
  default = "frontend"
}

variable "backend_instance_name" {
  default = "backend"
}

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "development"
    Terraform   = "true"
    developer   = "sivaramakrishna"
  }
}


variable "zone_name" {
  default = "ullagallubuffellomilk.store"
}