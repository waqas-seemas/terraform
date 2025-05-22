resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

# Primary scaling - Target Tracking for CPU
resource "aws_appautoscaling_policy" "cpu_target_tracking" {
  name               = "${var.app_name}-cpu-target"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = var.cpu_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

# Emergency scaling - Step Scaling for sudden spikes
resource "aws_appautoscaling_policy" "emergency_scale_out" {
  name               = "${var.app_name}-emergency-scale"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "PercentChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 50  # Scale up 50% immediately
    }
  }
}

# CloudWatch Alarm for emergency scaling
resource "aws_cloudwatch_metric_alarm" "emergency_high_traffic" {
  alarm_name          = "${var.app_name}-emergency-traffic"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = var.emergency_cpu_threshold
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Maximum"
  alarm_actions       = [aws_appautoscaling_policy.emergency_scale_out.arn]
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
}
