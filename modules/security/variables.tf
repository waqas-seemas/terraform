variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "container_port" {
  description = "Container port for ECS service"
  type        = number
  default     = 3000
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}