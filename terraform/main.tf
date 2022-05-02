terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "terraform-nhsd-apim-barz-temp"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      project     = var.project
      environment = local.environment
      tier        = "backend"
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "eu-west-2"
}
