locals {
  proxies_dir = "../proxies"
  apigee_name_prefix = "${var.project}-${local.apigee_environment}-${local.environment}"
  apigee_display_name_prefix = "${var.project} ${local.apigee_environment} ${local.environment}"

  live_proxy = {
    name = "${local.apigee_name_prefix}-live",
    source_dir = "${local.proxies_dir}/live"
  }
  sandbox_proxy = {
    name = "${local.apigee_name_prefix}-sandbox",
    source_dir = "${local.proxies_dir}/sandbox"
  }
}

module "apigee" {
  source = "./apigee"

  apigee_environment = local.apigee_environment
  company = var.project

  proxy = local.live_proxy

  app = {
    name = local.apigee_name_prefix
    display_name = local.apigee_display_name_prefix
    callback_url = null
    attributes = {
      "app_atr" = jsonencode({
        afoo: "abar"
      })
    }
  }

  product = {
    name = local.apigee_name_prefix
    display_name = local.apigee_display_name_prefix
    proxies = [local.live_proxy.name, "identity-service-${local.apigee_environment}"]
    scopes = []
    attributes = {
      "pro_atr" = jsonencode({
        pfoo: "pbar"
      })
    }
  }
}


