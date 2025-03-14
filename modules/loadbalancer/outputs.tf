output "tgt_grp_arn" {
    value = aws_lb_target_group.web_lb.arn
}

output "lb_dns_name" {
    value = aws_lb.alb-web.dns_name
  
}
output "lb_arn" {

    value = aws_lb.alb-web.arn
  
}