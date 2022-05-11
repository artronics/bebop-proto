resource "aws_ecs_cluster" "project_cluster" {
  for_each = var.environments
  name     = "${var.project.name}-${each.key}"
}
