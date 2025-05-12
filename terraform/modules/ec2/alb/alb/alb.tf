resource "aws_lb" "alb" {
  name = var.name
  internal = false
  load_balancer_type = "application"
  security_groups = var.security_groups
  subnets = var.subnets

  tags = {
    Name = "${var.project}-alb"
    project = var.project
    env = var.env
  }
}

resource "aws_lb_listener" "http_listner" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  
  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listner" {
  load_balancer_arn = aws_lb.alb.arn
  port = "443"
  protocol = "HTTPS"
  
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}