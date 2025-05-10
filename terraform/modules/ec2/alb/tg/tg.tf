resource "aws_lb_target_group" "tg"{
  name = var.name
  port = var.port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  tags = {
    Name = "${var.project}-${var.env}-tg"
    project = var.project
    env = var.env
  }
}