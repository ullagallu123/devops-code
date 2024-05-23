variable "profile" {
  default = "nv"
}

variable "region" {
  default = "us-east-1"
}
variable "instance_name" {
  default = ""
}

variable "ami" {
  default = "ami-0fe630eb857a6ec83"
}

variable "security_group_ip" {
  default = ["sg-005100434c5302ef1"]
}

variable "instance_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "siva"
}

variable "common_tags" {
  default = {
    developer   = "sivaram"
    environment = "testing"
  }
}