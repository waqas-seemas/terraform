variable "app_name" {
  description = "Application name for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for ALB resources"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "container_port" {
  description = "Container port for target group"
  type        = number
}

variable "health_check_path" {
  description = "Health check path for target group"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID for ALB"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}