resource "aws_kms_key" "example" {
  description = "KMS key creation for encrypt and decrypt for s3 bucket"
}

resource "aws_kms_key_policy" "example" {
  key_id = aws_kms_key.example.id
  policy = jsonencode({
    Id = "example"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}


resource "aws_kms_alias" "a" {
  name          = "alias/my-key-alias"
  target_key_id = aws_kms_key.example.key_id
}