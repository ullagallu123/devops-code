variable "sg_name" {
    type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "sg_description" {
    type = string
}

variable "ingree_rules" {
    type = list
    default = []
}

variable "common_tags" {
    type = map
}

variable "vpc_id" {
    type = string
}

variable "sg_tags" {
  type = map
  default = {}
}

variable "egress_rules" {
  type = list
  default = [
    {
      description = "by default allow all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}