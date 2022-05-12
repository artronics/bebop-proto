locals {
  sandbox_image = "790083933819.dkr.ecr.eu-west-2.amazonaws.com/bars-mock-receiver-jaho3-ecr-sandbox:latest"
}
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
      name      = "sandbox"
      #      image     = local.sandbox_image
      image     = local.sandbox_image
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
resource "aws_iam_role_policy" "main_ecs_tasks" {
  name = "${local.name_prefix}-policy"
  role = aws_iam_role.task_execution_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": ["*"]
        },
        {
            "Effect": "Allow",
            "Resource": [
              "*"
            ],
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:DescribeLogStreams"
            ]
        }
    ]

}
EOF
}
