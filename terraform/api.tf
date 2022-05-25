resource "aws_apigatewayv2_api" "service_api" {
  name                         = "${local.name_prefix}-api"
  description                  = "barz prototype mock-receiver service backend api - ${local.environment}"
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true
}

resource "aws_apigatewayv2_domain_name" "service_api_domain_name" {
  domain_name = local.api_record

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.service_certificate.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = {
    Name = "${local.name_prefix}-api-domain-name"
  }
}

resource "aws_apigatewayv2_api_mapping" "example" {
  api_id      = aws_apigatewayv2_api.service_api.id
  domain_name = aws_apigatewayv2_domain_name.service_api_domain_name.id
  stage       = aws_apigatewayv2_stage.default.id
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.service_api.id
  name        = local.environment
  auto_deploy = true

  # Bug in terraform-aws-provider with perpetual diff
  lifecycle {
    ignore_changes = [deployment_id]
  }
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.service_api.id
  route_key = "ANY /${var.service}/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.route.id}"
}

resource "aws_apigatewayv2_route" "root_route" {
  api_id    = aws_apigatewayv2_api.service_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.route_integration.id}"
}

resource "aws_apigatewayv2_route" "static" {
  api_id    = aws_apigatewayv2_api.service_api.id
  route_key = "ANY /static/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.static.id}"
}

resource "aws_apigatewayv2_integration" "route_integration" {
  api_id             = aws_apigatewayv2_api.service_api.id
  // TODO: chane this
  integration_uri    = aws_lb_listener.api_http_80.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = local.vpc_link_id
}


resource "aws_apigatewayv2_integration" "route" {
  api_id             = aws_apigatewayv2_api.service_api.id
  // TODO: chane this
  integration_uri    = aws_lb_listener.api_http_80.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = local.vpc_link_id
}

resource "aws_apigatewayv2_integration" "static" {
  api_id             = aws_apigatewayv2_api.service_api.id
  // TODO: chane this
  integration_uri    = aws_lb_listener.fixed_response.arn
  integration_type   = "HTTP_PROXY"
  integration_method = "GET"
  connection_type    = "VPC_LINK"
  connection_id      = local.vpc_link_id
}

resource "aws_apigatewayv2_deployment" "deployment" {
  depends_on  = [aws_apigatewayv2_route.this, aws_apigatewayv2_integration.route]
  api_id      = aws_apigatewayv2_api.service_api.id
  description = "BaRS api deployment"

  lifecycle {
    create_before_destroy = true
  }
}
