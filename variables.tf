variable "region" {
  default = "us-east-1"
}

variable "repo_name" {
  description = "ECR Repo Name"
  type = string
  default = "vproapp-repo"
}

variable "sg_ports" {
  type = list(number)
  default = [22, 443, 80, 8080]
}

variable "ecs_cluster_name" {
  description = "name of ecs cluster"
  type = string
  default = "vproapp"
}

variable "ecs_task_iam_role" {
  description = "Task Execution role for ECS"
  type = string
  default = "vproapp-task-ecs"
}

variable "container_name" {
  description = "Name of the Container"
  type = string
  default = "vproapp-task"
}

variable "cpu" {
  description = "CPU for containers"
  type = number
  default = 1024
}

variable "memory" {
  description = "Memory for Containers runtime"
  type = number
  default = 2048
}

variable "essential_container" {
  description = "Is container essential or not"
  type = bool
  default = true
}