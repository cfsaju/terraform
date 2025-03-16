variable "deployment_version" {
  type    = string
  default = "1.0"
}

variable "list_users" {
  type    = list(string)
  default = ["user1", "user2", "user3"] # List of users to create
}

variable "map_users" {
  type = map(string)
  default = {
    "user1" = "saju",
    "user2" = "seena"
    ""      = "Sanna"
  }

}

variable "vpc_cidr" {
  type = map(string)
  default = {
    "dev"  = "10.0.0.0/16"
    "prod" = "10.1.1.1/16"
  }

}

variable "environment" {
  type    = string
  default = "dev"

}

variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { description = "ssh access", to_port = 22, protocol = "tcp", from_port = 22, cidr_blocks = ["0.0.0.0/0"] },
    { description = "web access", to_port = 80, protocol = "tcp", from_port = 80, cidr_blocks = ["0.0.0.0/0"] },
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