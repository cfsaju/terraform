variable "ami_id" {
    type = string
    description = "AMI ID for the EC2 instance"
  
}

variable "instance_type" {
    type = string
    description = "EC2 instance type"
  
}

variable "subnet_id" {
    type = string
    description = "Subnet ID where EC2 will be deployed"
  
}

variable "ssh_key" {
    type = string
    description = "The public key to login to EC2 instances"
}

variable "sec_grp" {
    type = string
    description = "The secutiy group must be applied to instance"
  
}

variable "no_inst" {
    type = string
    description = "The number of the instance"
  
}