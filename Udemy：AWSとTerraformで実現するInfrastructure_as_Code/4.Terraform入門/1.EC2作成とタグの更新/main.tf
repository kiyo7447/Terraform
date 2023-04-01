# 無料枠 Amazon Linux 2023 AMI 2023.0.20230315.0 x86_64 HVM kernel-6.1 
resource "aws_instance" "hello-world" {
  ami           = "ami-067871d950411e643"
  instance_type = "t2.micro"
  # サブネットIDを設定して、VPC IDはどこにも使わない。
  subnet_id     = "subnet-0f56e84f28822953b"

  vpc_security_group_ids = [
    "sg-03b62a055c1a502c6",
  ]

  tags = {
    Name = "hello-world-hogehoge"
  }
}
