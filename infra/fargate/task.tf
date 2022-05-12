resource "aws_ecs_task_definition" "mock-receiver" {
  family                   = "${local.name_prefix}-task"
  network_mode             = "awsvpc"
  // ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.
  task_role_arn            = aws_iam_role.task_execution_role.arn
  //ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume.
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "rest-api"
      #      image     = local.sandbox_image
      image     = "vad1mo/hello-world-rest"
      essential = true

      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000

        }
      ]
    }
  ])
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${local.name_prefix}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
