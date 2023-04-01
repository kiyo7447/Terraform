provider "aws" {
  region  = "ap-northeast-1"
  profile = "myprofile"
}

locals {
  bucket_name = join("-", [var.base_name, "bucket"])
  iam_user_name = join("-", [var.base_name, "user"])
  iam_user_policy_name = join("-", [var.base_name, "policy"])
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.bucket_name
  # 子がからでなくても強制的に削除する。
  force_destroy = true
  #非推奨を削除して、ACLを設定に変える。
  #acl    = "private"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

locals {
  s3_folders = ["test/", "work/"]
}

resource "aws_s3_object" "folder" {
  for_each = toset(local.s3_folders)
  bucket   = aws_s3_bucket.s3_bucket.id
  key      = each.value
}

resource "aws_iam_policy" "s3_full_access" {
  name        = local.iam_user_policy_name    #"S3FullAccess"
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
  name = local.iam_user_name
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

