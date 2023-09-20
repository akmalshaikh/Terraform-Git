provider "aws" {
  region = var.region
}

resource "aws_security_group" "sg1" {
  name = "first_sg1"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb" {
  name               = "elastic-lb"
  availability_zones = ["ap-south-1a", "ap-south-1b"]

  listener {
    instance_port     = "80"
    instance_protocol = "http"
    lb_port           = "80"
    lb_protocol       = "http"
  }
  security_groups = [aws_security_group.sg1.id]
}