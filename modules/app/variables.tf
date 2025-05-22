variable "app_name" {
  description = "Application name used for resource naming"
  type        = string
  default     = "damodaran-seemas"
}

variable "container_port" {
  description = "Container port used by the app"
  type        = number
  default     = 3000
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.image_tag))
    error_message = "Image tag must be alphanumeric (no spaces/special chars)."
  }
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "stage" {
  description = "Deployment stage, e.g. beta or prod"
  type        = string
  validation {
    condition     = contains(["beta", "prod"], var.stage)
    error_message = "Stage must be one of: beta, prod."
  }
}

variable "acm_certificate_arn" {
  description = "ACM certificate "
  type        = string
  default     = "arn:aws:acm:us-east-1:050451403860:certificate/ca8e7c4d-2228-4d60-81ce-96f46ba000f8"
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "Docker image url"
  type        = string
}

variable "min_capacity" {
  description = "auto scales min capacity"
  type = number
}

variable "max_capacity" {
  description = "auto scales max capacity"
  type = number
}

variable "cpu_target_value" {
  description = "auto scales cpu target value"
  type = number
}

variable "emergency_cpu_threshold" {
  description = "auto scales emergency cpu threshold"
  type = number
}

variable "aws_region" {
  description = "region"
  type = string
}

variable "health_check_path" {
  description = "health check path"
  type = string
}
