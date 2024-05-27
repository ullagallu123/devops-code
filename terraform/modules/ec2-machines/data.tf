data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/expense/development/bastion-sg-id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/expense/development/public-subnet-ids"
}

data "aws_ami" "ami_info" {

  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}