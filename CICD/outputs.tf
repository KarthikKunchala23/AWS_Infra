output "ecs_task_definition_arn" {
  description = "task definition arn"
  value = aws_ecs_task_definition.ecs_task_definition.arn
}

output "ecs_service_name" {
  description = "ecs service name"
  value = aws_ecs_service.ecs_service.name
}

output "ecs_task_definition_name" {
  description = "name of task definition"
  value = aws_ecs_task_definition.ecs_task_definition.family
}