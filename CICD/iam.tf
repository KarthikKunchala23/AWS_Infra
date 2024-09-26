# IAM Role for CodePipeline
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "test-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM Policy for CodePipeline
data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect    = "Allow"
    actions   = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:ListDeploymentConfigs",
          "codedeploy:ListDeployments",
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
    ]
    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*",
      "*"  # Consider restricting this to specific resources
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.example.arn]
  }  

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

# IAM Role for CodeBuild
data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

# Custom IAM Policy for CodeBuild
resource "aws_iam_policy" "codebuild_policy" {
  name        = "custom-codebuild-policy"
  description = "Custom policy for CodeBuild access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:*",
          "s3:*",
          "codebuild:*",
          "ecr:*",
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach necessary policies to CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild_role.name
}



# IAM Role for CodeDeploy ECS
resource "aws_iam_role" "code_deploy_role" {
  name = "CodeDeployECSRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}


# # Attach the policy to the test-role
resource "aws_iam_role_policy_attachment" "test_role_codedeploy_policy" {
  role       = "CodeDeployECSRole"
  policy_arn = aws_iam_policy.codedeploy_policy.arn
}

# IAM Policy for CodeDeploy permissions
resource "aws_iam_policy" "codedeploy_policy" {
  name        = "CodeDeployPolicy"
  description = "Policy to allow CodeDeploy actions and connect with CodeStar"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "codedeploy:GetDeploymentConfig",
          "codedeploy:CreateDeployment",
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:GetApplication",
          "codedeploy:GetApplicationRevision",
          "codedeploy:GetDeployment",
          "codedeploy:CreateDeploymentGroup",
          "codedeploy:StopDeployment",
          "codedeploy:ContinueDeployment",
          "s3:*",
          "ecr:*",
          "ecs:*", 
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "codestar:CreateGitHubRepository",
          "codestar:DescribeProject",
          "codestar:GetProject",
          "codestar:ListProjects",
          "codestar:UpdateProject",
          "codestar:DeleteProject",
          "codestar:CreateConnection",
          "codestar:GetConnection",
          "codestar:DeleteConnection",
          "codestar:UpdateConnection",
          "codestar:ListConnections"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "iam:PassRole",
        "Resource": "arn:aws:iam::905418104867:role/CodeDeployECSRole",
        "Condition": {
          "StringEquals": {
            "iam:PassedToService": "codedeploy.amazonaws.com"
          }
        }
      }
    ]
  })
}




