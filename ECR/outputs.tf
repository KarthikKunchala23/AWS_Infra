output "ecr_image_url" {
  value = aws_ecr_repository.vproapp.repository_url
}

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

output "image_tag" {
  value = aws_ecr_repository.vproapp.tags_all
}