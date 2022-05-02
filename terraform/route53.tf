data "aws_route53_zone" "project_zone" {
  name = "${local.infra_env}.${var.project}.${var.domain_name}"
}
