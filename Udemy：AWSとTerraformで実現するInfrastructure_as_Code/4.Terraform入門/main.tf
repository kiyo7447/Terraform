# プロバイダー指定が大事
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# HTTP トラフィック（80番ポート）を許可するセキュリティグループを作成します。
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # イーグレスルールを設定・・・yumのUpdateに必要？
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Elastic IPアドレスを作成します。
resource "aws_eip" "example" {
  vpc = true
}

# EC2インスタンスの`user_data`を設定して、インスタンス起動時にNginxをインストール、有効化、および起動するようにします。
# 無料枠 Amazon Linux 2023 AMI 2023.0.20230315.0 x86_64 HVM kernel-6.1 
resource "aws_instance" "hello-world" {
  ami           = "ami-02a2700d37baeef8b"
  instance_type = "t2.micro"

  key_name      = "EC2_key_pair"   # 既存のEC2キーペア名を指定してください。新しいキーペアを作成する場合は、AWSマネジメントコンソールのEC2ダッシュボードで作成して、その名前を指定します。

  # サブネットIDを設定して、VPC IDはどこにも使わない。
  subnet_id     = "subnet-0f56e84f28822953b"

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  #vpc_security_group_ids = [
  #  "sg-03b62a055c1a502c6",
  #]

  tags = {
    Name = var.tag_name
    Spec = var.spec_variable
  }

  # ユーザーデータを設定
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
  EOF

  #無料枠のインスタンスは対応していない。
  #ebs_optimized = true

#エラーから原因がわかるものですかね。。。
#│ Error: creating EC2 Instance: Unsupported: The requested configuration is currently not supported. Please check the documentation for supported configurations.
#│       status code: 400, request id: db654457-bbdf-4a73-b00c-56ef167053d4
#│
#│   with aws_instance.hello-world,
#│   on main.tf line 20, in resource "aws_instance" "hello-world":
#│   20: resource "aws_instance" "hello-world" {
#│


  root_block_device {
    volume_size = 8
    delete_on_termination = true
  }

  associate_public_ip_address = true
}

resource "aws_eip_association" "hello-world" {
  instance_id = aws_instance.hello-world.id
  allocation_id = aws_eip.example.id
}
