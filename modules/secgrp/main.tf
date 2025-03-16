resource "aws_security_group" "web_sg" {
    name        = var.sg_name
    description = "Security group for ${var.sg_name}"
    vpc_id      = var.vpc_id

dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  
}
  # comment 1
}