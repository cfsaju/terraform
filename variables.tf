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
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
}