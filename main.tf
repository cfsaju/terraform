# Creating the VPC with one public subnet and one private subnet

locals {
  environment = "dev"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = "myVPC"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/27", "10.0.1.64/27"] # Two /27 subnets
  private_subnet_cidr = ["10.0.2.0/28"]
  availability_zone   = ["us-east-1a", "us-east-1b"]

}

# Creating the 3 EC2 instances 2 - Apache Servers ,  1 Aurora DB EC2 in private subnet
/* 
module "ec2" {

  depends_on  = [module.vpc]
  source      = "./modules/ec2"
  environment = local.environment
  ssh_key     = "mac-key"
  no_inst     = 2
  subnet_id   = module.vpc.public_subnet_id
  vpc_id      = module.vpc.vpc_id

  user_data = <<-EOF
   #!/bin/bash
   set -ex  # Enable debugging and exit on error
   apt update -y
   apt install -y apache2
   INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
   INSTANCE_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
   
   systemctl start apache2
   systemctl enable apache2
   
   cat <<EOT > /var/www/html/index.html
   <html>
   <head><title>EC2 Instance Info</title></head>
   <body>
   <h1>Welcome to Saju's Terraform Instances</h1>
   <p><strong>Private IP Address:</strong> $INSTANCE_IP</p>
   <p><strong>Hostname:</strong> $INSTANCE_HOSTNAME</p>
   </body>
   </html>
   EOT
   EOF
}

output "public_ip" {
  value = module.ec2.public_ip
}

# Create  Target group

module "loadbalancer" {
  source          = "./modules/loadbalancer"
  tgtgrp_name     = "web-tgt-grp1"
  tgtgrp_port     = "80"
  tgtgrp_protocol = "HTTP"
  vpc_id          = module.vpc.vpc_id

  # To create the Application Load Balancer
  lb_name    = "web-lb1"
  lb_subnets = module.vpc.public_subnet_id
  

}

# Attach the instances in the target group
resource "aws_lb_target_group_attachment" "lb_tgt_grp1_instances" {
  count            = length(module.ec2.instance_id)
  target_group_arn = module.loadbalancer.tgt_grp_arn
  target_id        = module.ec2.instance_id[count.index]
  port             = 80

}

# Create the listener and include the target groups

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = module.loadbalancer.lb_arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = module.loadbalancer.tgt_grp_arn
  }

}

output "lb_dns_name" {

  value = module.loadbalancer.lb_dns_name
  
}

# Create the AWS launch Template

resource "aws_launch_template" "webserver" {

  name = "webserver_template"
  image_id = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  key_name = "mac-key"

  network_interfaces {
    associate_carrier_ip_address = true
    security_groups = module.ec2.
  }
  
}
*/

/*
resource "aws_security_group" "web_sg" {

  
  name   = "web-sg1"
  vpc_id = module.vpc.vpc_id
  
  

  /*  
  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/
# The below dynamic directly calling variable using ingress
/*
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }

  }


}
  */

module "deployment_version_grp" {
  source  = "./modules/secgrp"
  sg_name = "dv-sg"
  vpc_id  = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow web access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    },
    {
      description = "Allow HTTPS"
      from_port = 443
      to_port = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]



}











