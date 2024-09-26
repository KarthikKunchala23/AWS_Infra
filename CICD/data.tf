data "aws_ecr_repository" "ecrrepo" {
  # depends_on = [ aws_ecr_repository.vproapp ]
  name = "nodeapp"
}

data "aws_ecr_image" "nodeimage" {
  repository_name = data.aws_ecr_repository.ecrrepo.name
  most_recent = true
}

# data "aws_code" "name" {
  
# }