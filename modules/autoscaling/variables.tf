variable "app_name" {
  description = "Application name for resource naming"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of tasks"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks"
  type        = number
  default     = 10
}

variable "cpu_target_value" {
  description = "Target CPU utilization percentage"
  type        = number
  default     = 65
}

variable "emergency_cpu_threshold" {
  description = "CPU threshold for emergency scaling"
  type        = number
  default     = 80
}

variable "scale_in_cooldown" {
  description = "Cooldown period after scale-in (seconds)"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Cooldown period after scale-out (seconds)"
  type        = number
  default     = 60
}

variable "cpu_low_threshold_step" {
  description = "CPU Utilization Percent to scale down"
  type        = number
  default     = 20
}

variable "cpu_high_threshold_step" {
   description = "CPU Utilization Percent to scale up"
    type        = number
    default     = 80
}
