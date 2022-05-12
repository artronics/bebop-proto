resource "aws_ecs_cluster" "project_cluster" {
  name = local.name_prefix
}

module "ecs-logger" {
  source      = "../ecs-logger"
  name_prefix = local.name_prefix
  cluster_arn = aws_ecs_cluster.project_cluster.arn
}
