module "app" {
  source = "git::https://github.com/waqas-seemas/terraform.git//modules/app?ref=main" # this points to your shared main.tf

  app_name                = var.app_name
  container_port          = var.container_port
  image_tag               = var.image_tag
  vpc_cidr                = var.vpc_cidr
  tags                    = var.tags
  stage                   = var.stage
  acm_certificate_arn     = var.acm_certificate_arn
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  ecr_repository_url      = var.ecr_repository_url
  min_capacity            = var.min_capacity
  max_capacity            = var.max_capacity
  cpu_target_value        = var.cpu_target_value
  emergency_cpu_threshold = var.emergency_cpu_threshold
  aws_region              = var.aws_region
  health_check_path       = var.health_check_path
}
