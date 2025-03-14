resource "aws_instance" "web" {
     count = var.no_inst
     ami = lookup(var.ami_id,"Ubuntu-22","ami-04b4f1a9cf54c11d0")
     instance_type = lookup(var.instance_type, var.environment, "ami-04b4f1a9cf54c11d0")
     subnet_id = element(var.subnet_id, count.index) # Distributes instances across subnets
     key_name = var.ssh_key
     user_data = var.user_data
     associate_public_ip_address = var.pub_ip_check
     vpc_security_group_ids = [aws_security_group.web_server_sg_tf.id]

     lifecycle {
        create_before_destroy = true
        ignore_changes = [user_data , ami, instance_type]
      }
     
   /*  root_block_device {
       volume_type = "gp2"
       volume_size = "8"
       delete_on_termination = true
     }
 */
     tags = {
       Name = "host-${count.index}"
     } 
}

resource "aws_security_group" "web_server_sg_tf" {
  name        = "public_sg"
  description = "Allow port 80 and 22 for web and ssh access"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP (port 80) and SSH (port 22) traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere

  }

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
    Name = "Public Security Group"
  }

}