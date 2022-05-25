resource "aws_apigatewayv2_vpc_link" "alb_vpc_link" {
  name               = local.name_prefix
  security_group_ids = [aws_security_group.nlb_security_group.id]
  // TODO: Only public ones?
  subnet_ids         = module.fargate.subnet_ids
}

resource "aws_security_group" "nlb_security_group" {
  name   = local.name_prefix
  vpc_id = aws_vpc.bebop-proto.id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
