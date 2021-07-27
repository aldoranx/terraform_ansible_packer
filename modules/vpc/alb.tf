#alb

resource "aws_lb" "dev-alb" {
  name               = var.alb-name
  internal           = var.internal
  load_balancer_type = var.load-balencer-type
  security_groups    = ["${aws_security_group.dev-alb-sg.id}"]
  subnets         = [aws_subnet.dev-public-subnet-01.id, aws_subnet.dev-public-subnet-02.id]

  tags = {
    Environment = var.alb-name
  }
}

# ALB TG
resource "aws_lb_target_group" "default" {
  name = "default-tg"

  port                 = var.http-port
  protocol             = upper(var.backend-protocol)
  vpc_id               = aws_vpc.main.id

  depends_on = [aws_lb.dev-alb]
}


# ALB HTTP Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.dev-alb.arn
  port              = var.http-port
  protocol          = var.protocol-http

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }

  depends_on = [aws_lb.dev-alb]
}

# ALB Redirect HTTP to HTTPS 
resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = "${aws_lb_listener.http.arn}"

  action {
    type = "redirect"

    redirect {
      port        = var.https-port
      protocol    = var.protocol-http
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["my-service.*.terraform.io"]
    }
  }
}