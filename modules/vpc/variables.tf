variable "vpc_name" {
    type = string
    description = "VPC Name"
}

variable "public_subnet_cidr" {
    type = string
    description = "CIDR block for the vpc"

}

variable "availability_zone" {
    type = string
    description = "Availability zone for the subnet"
  
}

variable "cidr_block" {
    type = string
    description = "CIDR block for the VPC"
}