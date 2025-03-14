variable "vpc_name" {
    type = string
    description = "VPC Name"
}

variable "public_subnet_cidr" {
    type = list(string)
    description = "public subnet block for the vpc"

}

variable "private_subnet_cidr" {
    type = list(string)
    description = "private subnet block for the VPC"
    default = []  # Empty string means optional
  
}

variable "availability_zone" {
    type = list(string)
    description = "Availability zone for the subnet"
    default = []
}


variable "cidr_block" {
    type = string
    description = "CIDR block for the VPC"
}