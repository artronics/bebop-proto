data "aws_route53_zone" "project_zone" {
  name = "${local.environment}.${var.project}.${var.domain_name}"
  depends_on = [module.project_infrastructure]
}
