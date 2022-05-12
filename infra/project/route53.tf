data "aws_route53_zone" "account_zone" {
  zone_id = var.account_zone_id
}

resource "aws_route53_zone" "project_zone" {
  name = "${var.environment}.${var.project.name}.${data.aws_route53_zone.account_zone.name}"
}

output "project_zone" {
  value = aws_route53_zone.project_zone.name
}
