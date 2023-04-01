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

# ローカルの test.txt をアップロード
with open('test.txt', 'rb') as data:
    s3.Bucket(bucket_name).put_object(Key='test/test.txt', Body=data)

print('test.txt uploaded to S3 test folder.')
