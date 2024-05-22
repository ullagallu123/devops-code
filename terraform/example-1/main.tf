resource "aws_instance" "db" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "HelloWorld"
  }
}


variable "ami" {
  default = "ami-0fe630eb857a6ec83"
}

variable "instance_type" {
  default = "t3.micro"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_ssh"
  description = "Allow ssh  inbound traffic and all outbound traffic"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}
