resource "aws_lb" "alb" {
  name            = var.alb_name
  subnets         = var.subnets
  security_groups = var.security_group_id
  internal        = false
  #Fix it later
  # access_logs {
  #   bucket = var.s3_bucket
  #   prefix = "ELB-logs"
  # }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listen_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_target.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group" "alb_target" {
  name     = var.alb_target_name
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  #implement sickness and health check
}


resource "aws_alb_target_group_attachment" "backend_service_one" {
  target_group_arn = aws_alb_target_group.alb_target.arn
  target_id        = var.target_one_id
  port             = var.target_port
}

resource "aws_alb_target_group_attachment" "backend_service_two" {
  target_group_arn = aws_alb_target_group.alb_target.arn
  target_id        = var.target_two_id
  port             = var.target_port
}