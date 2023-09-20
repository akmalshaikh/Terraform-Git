provider "aws" {
    region = var.region  
}

resource "aws_security_group" "sg1" {
    name = "first_sg1"

ingress{
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}
}

resource "aws_lb" "application-lb" {
    name = "application-lb"
    subnets = [ "subnet-03983c4ca9be0e56e","subnet-08c21f3709130c661" ]
    internal = false
    load_balancer_type = "application"
    enable_deletion_protection = false
    enable_http2 = true
    security_groups = [ aws_security_group.sg1.id ]
}

resource "aws_lb_target_group" "tg1" {
    name = "tg1"
    port = "80"
    protocol = "HTTP"
    vpc_id = "vpc-073140d8d5a5977ea" 
}

resource "aws_lb_target_group_attachment" "tg1-attach-1" {
    target_group_arn = aws_lb_target_group.tg1.arn
    target_id = "i-0402058a96fe5fe5f"
}

resource "aws_lb_target_group_attachment" "tg1-attach-2" {
  target_group_arn = aws_lb_target_group.tg1.arn
  target_id = "i-06ca07b18dbc5b925"
}