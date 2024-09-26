
data "aws_ecr_repository" "ecr" {
  # depends_on = [ aws_ecr_repository.vproapp ]
  name = var.repo_name
}

data "aws_ecr_image" "ecr_image" {
  # depends_on = [ aws_ecr_repository.vproapp ]
  repository_name = data.aws_ecr_repository.ecr.name
  image_tag = "latest"
}