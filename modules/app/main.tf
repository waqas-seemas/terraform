provider "aws" {
  region = var.aws_region  # For ECS/ALB resources
}

provider "aws" {
  alias  = "dns"
  region = var.aws_region  # Required for Route53 operations
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "network" {
  source          = "../network"
  app_name        = var.app_name
  vpc_cidr        = var.vpc_cidr
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  tags            = var.tags
}

module "security" {
  source   = "../security"
  app_name = var.app_name
  vpc_id   = module.network.vpc_id
  tags     = var.tags
}

module "alb" {
  source                = "../alb"
  app_name              = var.app_name
  vpc_id                = module.network.vpc_id
  public_subnets        = module.network.public_subnets
  container_port        = var.container_port
  health_check_path     = var.health_check_path
  acm_certificate_arn   = module.security.acm_certificate_arn
  alb_security_group_id = module.security.alb_security_group_id
  tags                  = var.tags
}

module "ecs" {
  source                = "../ecs"
  app_name              = var.app_name
  container_port        = var.container_port
  image_tag             = var.image_tag
  ecr_repository_url    = var.ecr_repository_url
  private_subnets       = module.network.private_subnets
  ecs_security_group_id = module.security.ecs_security_group_id
  alb_target_group_arn  = module.alb.alb_target_group_arn
  execution_role_arn    = module.security.ecs_task_execution_role_arn
  task_role_arn         = module.security.ecs_task_role_arn
  http_listener_arn     = module.alb.http_listener_arn
}

module "autoscaling" {
  source                  = "../autoscaling"
  app_name                = var.app_name
  cluster_name            = module.ecs.cluster_name
  service_name            = module.ecs.service_name
  min_capacity            = var.min_capacity // 1
  max_capacity            = var.max_capacity // 10
  cpu_target_value        = var.cpu_target_value //60
  emergency_cpu_threshold = var.emergency_cpu_threshold //80
}

# module "route53" {
#   source       = "../route53"
#   domain_name  = "seemas.ai"
#   stage        = var.stage    # "prod" or "beta"
#   alb_dns_name = module.alb.alb_dns_name
#   alb_zone_id  = module.alb.alb_zone_id
  
#   providers = {
#     aws.dns = aws.dns  # Pass the aliased provider
#   }
# }
