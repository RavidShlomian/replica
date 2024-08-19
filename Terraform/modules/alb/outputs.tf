#this was intented to output the dns_name of the alb so you can access it
output "lb_address" {
    value = aws_lb.alb.dns_name
}