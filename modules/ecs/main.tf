resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
  tags = { Name = "${var.app_name}-ecs-cluster" }
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.app_name}-app-task"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.app_name}-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([{
    name      = "app",
    image     = "${var.ecr_repository_url}:${var.image_tag}",
    essential = true,
    portMappings = [{
      containerPort = var.container_port,
      hostPort      = var.container_port,
      protocol      = "tcp"
    }],
    environment = [
      { name = "AWS_REGION", value = "us-east-1" },
      { name = "DEPLOY_TIMESTAMP", value = timestamp() }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "/ecs/${var.app_name}-app-task",
        "awslogs-region"        = "us-east-1",
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-app-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  # Add explicit dependency on ALB resources
  depends_on = [
    var.alb_target_group_arn,  # Wait for target group to be ready
    var.http_listener_arn      # Wait for listener to be ready
  ]

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "app"
    container_port   = var.container_port
  }

  # Enable deployment circuit breaker
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # Ensure healthy instances before traffic shift
  deployment_controller {
    type = "ECS"
  }
}
