variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
}

variable "container_port" {
  description = "Container port for ECS service"
  type        = number
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for ECS"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "image_tag" {
  description = "Tag of the container image to deploy"
  type        = string
  default     = "latest"
}

variable "http_listener_arn" {
  description = "ARN of the HTTP listener (for dependency)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}