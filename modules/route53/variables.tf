variable "domain_name" {
  description = "Your domain name (e.g., damodaran.seemas.ai)"
  type        = string
  default = ".seemas.ai"
} 

variable "alb_dns_name" {
  description = "Production ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "Production ALB zone ID"
  type        = string
}

# For both examples
variable "stage" {
  description = "Deployment stage (e.g., beta, prod)"
  type        = string
}
