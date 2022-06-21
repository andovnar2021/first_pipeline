locals {
  ws_name = terraform.workspace
}

resource "aws_ecs_cluster" "web-cluster" {
  name = "${local.ws_name}-${var.cluster_name}"
  # capacity_providers = [aws_ecs_capacity_provider.app-checking.name]
  tags = {
    Name        = "${var.app_name}-cluster"
    Environment = var.app_environment
  }
}

# resource "aws_ecs_capacity_provider" "app-checking" {
#   name = "capacity-provider"
#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
#     managed_termination_protection = "ENABLED"

#     managed_scaling {
#       status          = "ENABLED"
#       target_capacity = 85
#     }
#   }
# }

# update file container-def, so it's pulling image from ecr
resource "aws_ecs_task_definition" "task-definition" {
  family                   = "${local.ws_name}-my-flask-app"
  container_definitions    = file(var.path_to_file)
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  tags = {
    Name        = "${local.ws_name}-task-def"
    Environment = var.app_environment
  }
}

resource "aws_ecs_service" "service" {
  name                = "${local.ws_name}-${var.app_name}-service"
  cluster             = aws_ecs_cluster.web-cluster.id
  task_definition     = aws_ecs_task_definition.task-definition.arn
  scheduling_strategy = "REPLICA"
  desired_count       = 2

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = var.container_name
    container_port   = 80
  }


  launch_type = "EC2"
  depends_on = [
    aws_lb_listener.web-listener,
    aws_autoscaling_group.asg
  ]
}

# resource "aws_cloudwatch_log_group" "log_group" {
#   name = "/ecs/frontend-container"
#   tags = {
#     Name        = "${var.app_name}-logs"
#     Environment = var.app_environment
#   }
# }