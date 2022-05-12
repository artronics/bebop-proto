locals {
  subnets_cidr = [var.subnets[0].cidr, var.subnets[1].cidr]
}
resource "aws_ecs_service" "mock-receiver-service" {
  name            = "${local.name_prefix}-service"
  cluster         = aws_ecs_cluster.fargate-cluster.id
  task_definition = aws_ecs_task_definition.mock-receiver.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private_subnets.*.id
    assign_public_ip = true
  }

}

resource "aws_security_group" "ecs_tasks" {
  name   = "${local.name_prefix}-sg-task"
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
