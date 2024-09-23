data "aws_iam_policy_document" "role" {
  statement {
    sid    = "ECR Policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::905418104867:user/Terraform", "arn:aws:iam::905418104867:user/jenkins"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

data "aws_ecr_repository" "ecr" {
  name = var.repo_name
}

data "aws_ecr_image" "ecr_image" {
  repository_name = data.aws_ecr_repository.ecr.name
  image_tag = "latest"
}