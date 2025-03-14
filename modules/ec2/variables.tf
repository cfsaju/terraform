variable "ami_id" {
    type = map(string)
    default = {
        "ubuntu-24" = "ami-04b4f1a9cf54c11d0",
        "Ubuntu-22" = "ami-0e1bed4f06a3b463d"
    }
    description = "AMI ID for the EC2 instance"
  
}



variable "instance_type" {
    description = "EC2 instance type"
    type = map(string)
    default =  {
        "dev"  = "t2.micro",
        "prod" = "t2.large",
        "qa"   = "t2.nano"
    }
   
  
}

variable "environment" {
  description = "Deployment environment (dev, prod, qa)"
  type        = string
}

variable "subnet_id" {
    type = list(string)
    description = "Subnet ID where EC2 will be deployed"
  
}

variable "ssh_key" {
    type = string
    description = "The public key to login to EC2 instances"
    default = "mac-key"
}

variable "sec_grp" {
    type = string
    description = "The secutiy group must be applied to instance"
    default = ""
  
}

variable "no_inst" {
    type = string
    description = "The number of the instance"
  
}

variable "user_data" {
  type        = string
  description = "User data script for EC2 instance initialization"
  default     = ""
}

variable "sec_group" {
    type = string
    description = "Security Group needs to be applied to the EC2 instances"
    default = ""
}

variable "vpc_id" {
    type = string
    description = "Security Group needs to be applied to the EC2 instances"
    
}

variable "pub_ip_check" {
    type = bool
    description = "Provide public IP to the instance or not"
    default = true
  
}