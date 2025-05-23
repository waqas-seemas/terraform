variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

# variable "AWS_ACCESS_KEY_ID" {
#   type      = string
#   sensitive = true
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   type      = string
#   sensitive = true
# }

# variable "AWS_SESSION_TOKEN" {
#   type      = string
#   sensitive = true
# }
variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
}

variable "container_port" {
  description = "Container port exposed by the application"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of ECS tasks for autoscaling"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks for autoscaling"
  type        = number
}

variable "cpu_target_value" {
  description = "Target CPU utilization for autoscaling"
  type        = number
}

variable "emergency_cpu_threshold" {
  description = "Threshold for emergency scaling based on CPU usage"
  type        = number
}

variable "stage" {
  description = "Deployment stage (e.g., beta or prod)"
  type        = string
  validation {
    condition     = contains(["beta", "prod"], var.stage)
    error_message = "Stage must be one of: beta, prod."
  }
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the application"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL of the Docker image repository"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for the load balancer"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
