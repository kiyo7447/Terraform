import boto3
import os

# 環境変数からアクセスキーとシークレットキーを読み込む
ACCESS_KEY = os.environ['AWS_ACCESS_KEY_ID']
SECRET_KEY = os.environ['AWS_SECRET_ACCESS_KEY']

# Terraformで発行されたアクセスキーとシークレットキーを使用
# ACCESS_KEY = 'your_access_key'
# SECRET_KEY = 'your_secret_key'

# S3バケット名
BUCKET_NAME = 'kiyo7447-s3test-backet'

# リージョン
REGION = 'ap-northeast-1'

# クライアントの作成
s3 = boto3.client('s3', aws_access_key_id=ACCESS_KEY, aws_secret_access_key=SECRET_KEY, region_name=REGION)

# ファイルをアップロード（書き込み）
def upload_file(file_path, key):
    s3.upload_file(file_path, BUCKET_NAME, key)
    print(f"Uploaded {file_path} to {BUCKET_NAME}/{key}")

# ファイルをダウンロード（読み込み）
def download_file(key, dest_path):
    s3.download_file(BUCKET_NAME, key, dest_path)
    print(f"Downloaded {BUCKET_NAME}/{key} to {dest_path}")

# テスト
if __name__ == "__main__":
    test_file_path = "test.txt"
    key = "test/test.txt"

    # テストファイルのアップロード
    upload_file(test_file_path, key)

    # テストファイルのダウンロード
    download_file(key, "downloaded_test.txt")
