# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

#基本設定
provider "aws" {
  region = "ap-northeast-1" #東日本リージョン
}

locals {
  bucket_name = join("-", [var.base_name, "bucket"])
  iam_user_name = join("-", [var.base_name, "user"])
  iam_user_policy_name = join("-", [var.base_name, "policy"])
}

#バケットの作成
resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${local.bucket_name}/*"
        Principal = "*"
      }
    ]
  })
}

resource "null_resource" "folders" {
  triggers = {
    bucket = aws_s3_bucket.this.id
  }

  provisioner "local-exec" {
    command = <<EOC
      aws s3api put-object --bucket ${local.bucket_name} --key test/
      aws s3api put-object --bucket ${local.bucket_name} --key work/
    EOC
  }
}

