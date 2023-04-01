provider "aws" {
  region = "us-west-2" # 任意のリージョンを選択してください
}

resource "aws_s3_bucket" "example_bucket_abe" {
  bucket = "my-example-bucket-abe" # 一意なバケット名を指定してください
  acl    = "public-read"

  tags = {
    Name        = "My Example Bucket"
    Environment = "Development"
  }
}
