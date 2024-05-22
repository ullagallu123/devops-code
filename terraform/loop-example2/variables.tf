variable "profile" {
  default = "nv"
}

variable "region" {
  default = "us-east-1"
}
variable "instance_names" {
  default = {
    "db"       = "t3.micro",
    "backend"  = "t3.micro",
    "frontend" = "t3.micro"
  }
}

variable "ami" {
  default = "ami-0fe630eb857a6ec83"
}

variable "key_name" {
  default = "siva"
}
variable "sg_name" {
  default = "allow_ssh"
}

variable "sg_description" {
  default = "Allow ssh  inbound traffic and all outbound traffic"
}

variable "ssh_port" {
  default = 22
}

variable "protocol" {
  default = "tcp"
}

variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "common_tags" {
  default = {
    Project     = "wages"
    Environment = "testing"
    Developer   = "sivaram"
    Terraform   = "yes"
  }
}

variable "zone_id" {
  default = "Z102029611EGT6KU94A16"
}

variable "domain_name" {
  default = "ullagallubuffellomilk.store"
}