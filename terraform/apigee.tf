module "apigee" {
  source = "./apigee"
  name_prefix = "${var.project}-${local.apigee_environment}-${local.environment}"
  apigee_environment = local.apigee_environment
}
