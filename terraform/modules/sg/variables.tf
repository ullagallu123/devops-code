variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "development"
}

variable "db_sg_name" {
  default = "db"
}

variable "backend_sg_name" {
  default = "backend"
}

variable "frontend_sg_name" {
  default = "frontend"
}

variable "ansible_sg_name" {
  default = "ansible"
}

variable "bastion_sg_name" {
  default = "bastion"
}