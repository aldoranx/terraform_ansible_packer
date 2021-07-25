output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.dev-webserver-subnet.id
}

output "alb_arn" {
  value = aws_lb.dev-alb.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.http.arn
}