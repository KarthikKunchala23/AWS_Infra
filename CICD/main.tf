# resource "aws_codepipeline" "codepipeline" {
#   name     = "nodejs-pipeline"
#   role_arn = aws_iam_role.codepipeline_role.arn
#   pipeline_type = "V2"
#   execution_mode = "QUEUED"

#   artifact_store {
#     location = aws_s3_bucket.codepipeline_bucket.bucket
#     type     = "S3"

#     encryption_key {
#       id   = data.aws_kms_alias.s3kmskey.arn
#       type = "KMS"
#     }
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "Source"
#       category         = "Source"
#       owner            = "AWS"
#       provider         = "CodeStarSourceConnection"
#       version          = "1"
#       output_artifacts = ["source_output"]

#       configuration = {
#         ConnectionArn    = aws_codestarconnections_connection.example.arn
#         FullRepositoryId = "KarthikKunchala23/nodecicd"
#         BranchName       = "master"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       input_artifacts  = ["source_output"]
#       output_artifacts = ["build_output"]
#       version          = "1"

#       configuration = {
#         ProjectName = aws_codebuild_project.docker_build_project.name
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name            = "Deploy"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "CodeDeploy"
#       input_artifacts = ["build_output"]
#       version         = "1"

#       configuration = {
#        ApplicationName     = "your-ecs-application"
#        DeploymentGroupName = "your-deployment-group"
#       }
#     }
#   }
# }

# resource "aws_codestarconnections_connection" "example" {
#   name          = "example-connection"
#   provider_type = "GitHub"
# }

# resource "aws_s3_bucket" "codepipeline_bucket" {
#   bucket = "test-bucket-hp-run-jump"
# }

# resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
#   bucket = aws_s3_bucket.codepipeline_bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }


# resource "aws_iam_role_policy" "codepipeline_policy" {
#   name   = "codepipeline_policy"
#   role   = aws_iam_role.codepipeline_role.id
#   policy = data.aws_iam_policy_document.codepipeline_policy.json
# }

# data "aws_kms_alias" "s3kmskey" {
#   depends_on = [ aws_kms_alias.a ]
#   name = "alias/my-key-alias"
# }