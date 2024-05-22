variable "profile" {
  default = "nv"
}

variable "region" {
  default = "us-east-1"
}

variable "sg_name" {
  default = "allow_ssh"
}

variable "sg_description" {
  default = "Allow ssh  inbound traffic and all outbound traffic"
}

variable "ingree_rules" {
  default = [
    { 
      description="allows ssh port"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description="allows http port"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description="allows https port"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description="allows mysql port"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "common_tags" {
  default = {
    developer   = "sivaram"
    environment = "testing"
  }
}