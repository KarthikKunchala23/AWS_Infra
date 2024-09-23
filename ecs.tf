
# ECS Cluster
resource "aws_ecs_cluster" "example" {
  name = var.ecs_cluster_name
}

# Task Definition
resource "aws_ecs_task_definition" "example" {
  family                   = "my-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  
  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${data.aws_ecr_image.ecr_image.image_uri}",
      "cpu": ${var.cpu},
      "memory": ${var.memory},
      "essential": ${var.essential_container},
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ]
    }
  ]
  TASK_DEFINITION
}

# ${data.aws_ecr_image.ecr_image.image_uri}
# VPC for the network
resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnets
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.ecs_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "example_subnet_2" {
  vpc_id     = aws_vpc.ecs_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.ecs_vpc.id

  dynamic "ingress" {
    for_each = var.sg_ports
    # iterator = "port"
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
}

# Create an ALB (Application Load Balancer)
resource "aws_lb" "example" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = [aws_subnet.example.id, aws_subnet.example_subnet_2.id]
}

# Create a target group for the ALB
resource "aws_lb_target_group" "example" {
  name        = "ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecs_vpc.id
  target_type = "ip"  # Required for Fargate
#   health_check {
#     path = "/login"
#   }
}

# Listener for ALB
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

# ECS Service with Fargate launch type and Load Balancer
resource "aws_ecs_service" "example" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  launch_type     = "FARGATE"

  desired_count = 2  # Set to 0 to prevent container from running initially

  network_configuration {
    subnets          = [aws_subnet.example.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.example.arn
    container_name   = "ecs-vproapp-container"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [desired_count]  # Ignore changes to the desired count
  }

  depends_on = [aws_lb_listener.example]
}

