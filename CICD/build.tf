# CodeBuild Project
resource "aws_codebuild_project" "docker_build_project" {
  name          = "docker-build-project"
  service_role  = aws_iam_role.codebuild_role.arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-east-1"  # Update with your desired region
    }
    environment_variable {
      name  = "REPOSITORY_URI"
      value = "905418104867.dkr.ecr.us-east-1.amazonaws.com/nodeapp"  # Replace with your ECR repo URI
    }
    privileged_mode = true  # Required for Docker
  }
  source {
    type            = "CODEPIPELINE"  # Updated to CODEPIPELINE
    buildspec       = "buildspec.yml"  # Ensure this file exists in your repo
  }
}