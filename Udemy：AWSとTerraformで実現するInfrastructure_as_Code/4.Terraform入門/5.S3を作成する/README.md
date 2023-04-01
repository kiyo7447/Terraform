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
Pythonが使用するアクセスキーとシークレットキーの指定は環境変数で受け取る。

Pythonのコードはローカルのカレントにあるtest.txtをS3のtestフォルダにアップロードして、その後、S3のworkフォルダにあるwork.txtをダウンロードするコードにしてください。
あと、Pythonが使用するS3へのアクセスキーとシークレットキーは、環境変数から取得してください。


# aws_cliユーザの設定
アクセスキー、シークレットキーを取得して下記のコマンドを実行する
```bash
$ aws configure --profile myprofile
AWS Access Key ID [None]: (your_access_key)
AWS Secret Access Key [None]: (your_secret_key)
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

```HCL2
# myprofileを使用する
provider "aws" {
  region  = "ap-northeast-1"
  profile = "myprofile"
}
```


# Python
pip install boto3

# Bash

export AWS_ACCESS_KEY_ID=AKIAYSKHM5YT22YSDHNX
export AWS_SECRET_ACCESS_KEY=XXXXX


# 作成コマンド
```bash
terraform apply

terraform apply -var 'bucket_name=new-bucket-name'



```
