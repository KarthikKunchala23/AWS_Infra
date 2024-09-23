output "ecr_arn" {
  description = "ECR ARN"
  value = aws_ecr_repository.vproapp.arn
}

output "registry_id" {
  description = "registry id"
  value = aws_ecr_repository.vproapp.registry_id
}

output "repo_url" {
  description = "repositry url"
  value = aws_ecr_repository.vproapp.repository_url
}

output "sg_id" {
  description = "value"
  value = aws_security_group.ecs_sg.id
}

output "ecs_cluster_name" {
  description = "ecs cluster name"
  value = aws_ecs_cluster.example.name
}

output "ecs_cluster_service_name" {
  description = "ecs service name"
  value = aws_ecs_service.example.name
}

output "lb_dns" {
  description = "load balancer dns"
  value = aws_lb.example.dns_name
}