output "scaling_target_arn" {
  description = "ARN of the scaling target"
  value       = aws_appautoscaling_target.ecs_target.resource_id
}
