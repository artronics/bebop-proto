terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "terraform-nhsd-apim-bebop-barz"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
  profile = "apim-dev"

  default_tags {
    tags = {
      project     = var.project
      environment = local.environment
      tier        = "proxy"
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "eu-west-2"
}
