# resource "aws_ecr_repository" "vproapp" {
#   name = var.repo_name
#   image_tag_mutability = "MUTABLE"
# #   encryption_configuration {
# #     encryption_type = ""
# #   }

#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   tags = local.tags
# }

# resource "aws_ecr_repository_policy" "iamRole" {
#   repository = aws_ecr_repository.vproapp.name
#   policy = data.aws_iam_policy_document.role.json
# }

# resource "aws_ecr_lifecycle_policy" "policy" {
#   repository = aws_ecr_repository.vproapp.name

#   policy = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Expire images older than 14 days",
#             "selection": {
#                 "tagStatus": "untagged",
#                 "countType": "sinceImagePushed",
#                 "countUnit": "days",
#                 "countNumber": 14
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }


# locals {
#   tags = {
#     Name = "ECR_REPO_VPROAPP"
#   }
# }