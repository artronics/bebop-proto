resource "aws_ecr_repository" "docker-registry" {
  name = local.name_prefix
}

output "registry_id" {
  value = aws_ecr_repository.docker-registry.id
}
