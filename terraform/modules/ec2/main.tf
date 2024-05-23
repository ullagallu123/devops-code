module "example_ec2" {
  source        = "../../../ec2"
  ami           = var.ami
  key_name      = var.key_name
  instance_type = var.instance_type
  # Here why con't i define vpc_security_greoup argument when i was define i get error you cannot define
}

