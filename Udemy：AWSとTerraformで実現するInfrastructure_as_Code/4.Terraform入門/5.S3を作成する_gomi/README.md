# 依頼
Terraformを使ってS3を作りたいです。
条件は、
バケット名は、kiyo7447-s3test-backet
フォルダにtestフォルダとworkフォルダの２つを作ってください。
リージョンは、東日本
アクセスは、WinSCPとPythonアプリから行います。
WinSCPを使って接続できるようにする。
また、アプリから接続キーを発行する。
WinSCPとアプリからは、S3へｎFullAccess権限を与える。
アプリケーションはPythonで、データの書込と読み込みのサンプルを提示する。

# 

# Python
pip install boto3

# Bash

export AWS_ACCESS_KEY_ID=AKIAYSKHM5YT2KSNO5YV
export AWS_SECRET_ACCESS_KEY=XXXXX


# 作成コマンド
```bash
terraform apply

terraform apply -var 'bucket_name=new-bucket-name'


```
