resource "aws_security_group" "service_security_group" {
  name   = var.name_prefix
  vpc_id = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_ecs_service" "mock-receiver-service" {
  name             = var.name_prefix
  cluster          = var.cluster_id
  task_definition  = aws_ecs_task_definition.mock-receiver.arn
  platform_version = "1.4.0"
  # 1.3.0 doesn't need a vpc_endpoint to *.ecr.api see:https://docs.aws.amazon.com/AmazonECR/latest/userguide/vpc-endpoints.html
  desired_count    = 3
  launch_type      = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.service_security_group.id]
    subnets          = var.subnet_ids
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.http_80_tg.arn
    container_name   = "mock-receiver"
    container_port   = var.container_port
  }
}

