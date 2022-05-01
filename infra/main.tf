terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket = "terraform-artronics-bebop-infra"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      project     = "${var.project}-infra"
      environment = local.environment
      tier        = "infrastructure"
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "eu-west-2"
}
