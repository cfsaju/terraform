resource "aws_lb_target_group" "web_lb" {
  name     = var.tgtgrp_name
  port     = var.tgtgrp_port
  protocol = var.tgtgrp_protocol
  vpc_id   = var.vpc_id
}


resource "aws_security_group" "alb_sg1" {
  name        = "alb_sg"
  description = "Allow port 80 for the application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  # Allow all outbound traffic (default)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Load Balancer Security Group"
  }
}



resource "aws_lb" "alb-web" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg1.id]
  subnets            = var.lb_subnets
  
  tags = {
    Environment = "production"
  }
}


