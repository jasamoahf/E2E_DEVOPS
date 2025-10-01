locals {
  name = "${var.project}-${var.env}"
  tags = merge({
    Project = var.project
    Env     = var.env
  }, var.tags)
}

module "vpc" {
  source              = "./modules/vpc"
  name                = local.name
  az_count            = 2
  tags                = local.tags
}

module "s3" {
  source      = "./modules/s3"
  name        = local.name
  create_logs = true
  tags        = local.tags
}

module "ecr" {
  source = "./modules/ecr"
  name   = local.name
  tags   = local.tags
}

module "iam" {
  source = "./modules/iam"
  name   = local.name
  tags   = local.tags
}

module "ecs" {
  source                 = "./modules/ecs"
  name                   = local.name
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  public_subnet_ids      = module.vpc.public_subnet_ids
  container_port         = var.container_port
  desired_count          = var.desired_count
  cpu                    = var.cpu
  memory                 = var.memory
  ecr_repository_url     = module.ecr.repository_url
  image_tag              = var.container_image_tag
  ecs_task_execution_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
  tags                   = local.tags
}
