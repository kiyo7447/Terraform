provider "aws" {
  region  = "ap-northeast-1"
  profile = "myprofile"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "kiyo7447-s3test-bucket"
  # 子がからでなくても強制的に削除する。
  force_destroy = true
  acl    = "private"
}

locals {
  s3_folders = ["test/", "work/"]
}

resource "aws_s3_bucket_object" "folder" {
  for_each = toset(local.s3_folders)
  bucket   = aws_s3_bucket.s3_bucket.id
  key      = each.value
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccess"
  description = "Full access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.s3_bucket.arn}/*"]
      }
    ]
  })
}


resource "aws_iam_user" "app_user" {
  name = "app_user"
  force_destroy = true
}

resource "aws_iam_access_key" "app_key" {
  user = aws_iam_user.app_user.name
}

resource "aws_iam_user_policy_attachment" "app_user_full_access" {
  policy_arn = aws_iam_policy.s3_full_access.arn
  user       = aws_iam_user.app_user.name
}

output "app_user_access_key" {
  value = aws_iam_access_key.app_key.id
}

output "app_user_secret_key" {
  value = aws_iam_access_key.app_key.secret
  sensitive = true
}

