resource "aws_instance" "web" {
     count = var.no_inst
     ami = var.ami_id
     instance_type = var.instance_type
     subnet_id = var.subnet_id 
     key_name = var.ssh_key
     security_groups = [ var.sec_grp ]

     tags = {
       Name = "Web Server-${count.index}"
     } 
}