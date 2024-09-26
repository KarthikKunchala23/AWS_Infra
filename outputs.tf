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