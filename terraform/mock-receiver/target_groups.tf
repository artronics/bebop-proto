resource "aws_lb_target_group" "http_80_tg" {
  name        = "${var.name_prefix}-http-80"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip" // TODO: correct? if none -> incompatible with "awsvpc" in task_def
  vpc_id      = var.vpc_id

  health_check {
    path = "/_status"
  }
}
