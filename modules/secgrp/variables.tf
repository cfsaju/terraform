variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { description = "ssh access", to_port = 22, protocol = "tcp",from_port = 22, cidr_blocks = ["0.0.0.0/0"] },
    { description = "web access", to_port = 80, protocol = "tcp", from_port=80, cidr_blocks = ["0.0.0.0/0"] },
    { description = "Allow HTTPS", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

variable "egress_rules" {
  type = list(object({
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = list(string)
  }))

  default = [{
    from_port = 0, to_port = 0, protocol = "-1", cidr_block = ["0.0.0.0/0"]
  }]

}

variable "vpc_id" {

  type = string
  description = "VPC id"
  
}

variable "sg_name" {
  type = string
  
}

