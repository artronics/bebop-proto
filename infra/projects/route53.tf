data "aws_route53_zone" "account_zone" {
  name = var.account_zone_name
}

resource "aws_route53_zone" "project_zone" {
  name     = "${var.environment}.${var.project.name}.${data.aws_route53_zone.account_zone.name}"
}

output "project_zone_id" {
  value = aws_route53_zone.project_zone.id

}
