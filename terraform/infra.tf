data "terraform_remote_state" "barz-infra" {
  backend = "s3"
  config  = {
    bucket = "terraform-nhsd-apim-bebop-proto-infra"
    key    = "infra"
    region = "eu-west-2"
  }
}

locals {
  vpc_id = data.terraform_remote_state.barz-infra.outputs.vpc_id
}

# fargate outputs
locals {
  fargate_subnets_ids     = data.terraform_remote_state.barz-infra.outputs.fargate_subnet_ids
  fargate_cluster_id      = data.terraform_remote_state.barz-infra.outputs.fargate_cluster_id
  fargate_repository_url  = data.terraform_remote_state.barz-infra.outputs.fargate_repository_url
  fargate_repository_name = data.terraform_remote_state.barz-infra.outputs.fargate_repository_name
}

locals {
  repositories = ["mock-receiver"]

  mock_receiver_repository_url  = local.fargate_repository_url[local.repositories[0]]
  mock_receiver_repository_name = local.fargate_repository_name[local.repositories[0]]
}

locals {
  alb_arn     = data.terraform_remote_state.barz-infra.outputs.alb_arn
  vpc_link_id = data.terraform_remote_state.barz-infra.outputs.vpc_link_id
}
