variable "vpc_id" {
    type = string
    description = "VPC id for load balancer"
    
}

variable "tgtgrp_name" {
    type = string
    description = "Name of the Target group"
    default = ""
}

variable "tgtgrp_port" {
    type = string
    description = "Port used for target group"
    default = ""
}

variable "tgtgrp_protocol" {
    type = string
    description = "Protocol used for targetgroup"
    default = ""
}

variable "lb_sg" {

    type = list(string)
    description = "Security Group for the load balancer"
    default = []
}

variable "lb_subnets" {

    type = list(string)
    description = "Subnets to be associated with load balancer"
    default = []
}

variable "lb_name" {

    type = string
    description = "Subnets to be associated with load balancer"
   
  
}