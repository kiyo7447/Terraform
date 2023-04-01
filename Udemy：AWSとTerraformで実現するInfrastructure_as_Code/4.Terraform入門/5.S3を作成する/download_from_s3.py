import boto3
import os

# 環境変数からアクセスキーとシークレットキーを読み込む
aws_access_key_id = os.environ['AWS_ACCESS_KEY_ID']
aws_secret_access_key = os.environ['AWS_SECRET_ACCESS_KEY']

# AWS アクセスキーとシークレットキーを設定します
# aws_access_key_id = 'your_access_key_id'
# aws_secret_access_key = 'your_secret_access_key'

session = boto3.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    region_name='ap-northeast-1'
)

s3 = session.resource('s3')

bucket_name = 'kiyo7447-s3test-bucket'

# S3 の work フォルダから work.txt をダウンロード
s3.Bucket(bucket_name).download_file('work/work.txt', 'work_downloaded.txt')

print('work.txt downloaded from S3 work folder to local as work_downloaded.txt.')
