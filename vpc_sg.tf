####################
# Webサーバーが端末のグローバルIPからSSH/SFTPとHTTPを受け入れるSG設定
####################
# WebサーバーがSSHとHTTPを受け付けるSGの構築
resource "aws_security_group" "pub_a" {

 # セキュリティグループ名を設定
 name = "sg_pub_a"
 
 # セキュリティグループを構築するVPCのIDを設定
 vpc_id = aws_vpc.vpc.id
 
 
 # タグを設定
 tags = {
   Name = "sg-pub-a"
 }
}

# 出て行く通信の設定
resource "aws_security_group_rule" "egress_pub_a" {

 # このリソースが通信を受け入れる設定であることを定義
 # egressを設定
 type = "egress"
 
 # ポートの範囲設定
 # 全てのトラフィックを許可する場合いずれも0で設定
 from_port = 0
 to_port = 0
 
 # プロトコル設定
 # 以下は全てのIPv4トラフィックを許容する設定
 protocol = "-1"
 
 # 許可するIPの範囲を設定
 # 以下は全てのIPv4トラフィックを許容する設定
 cidr_blocks = ["0.0.0.0/0"]
 
 # このルールを付与するセキュリティグループを設定
 security_group_id = aws_security_group.pub_a.id
}

# SSH/SFTPを受け入れる設定
resource "aws_security_group_rule" "ingress-pub-a-22" {

  # このリソースが通信を受け入れる設定であることを定義
  # ingressを設定
  type = "ingress"
  
  # ポートの範囲設定
  from_port = "22"
  to_port = "22"
  
  # プロトコルはtcpを設定
  protocol = "tcp"
  
  # 許可するIPの範囲を設定
  # 自身のグローバルIPを記入してください
  cidr_blocks = ["101.111.161.148/32"]
  
  # このルールを付与するセキュリティグループを設定
  security_group_id = aws_security_group.pub_a.id
}

# HTTPを受け入れる設定
resource "aws_security_group_rule" "ingress_pub_a_80" {

  # このリソースが通信を受け入れる設定であることを定義
  # ingressを設定
  type = "ingress"
  
  # ポートの範囲設定
  from_port = "80"
  to_port = "80"
  
  # プロトコルはtcpを設定
  protocol = "tcp"
  
  # 許可するIPの範囲を設定
  # 自身のグローバルIPを記入してください
  cidr_blocks = ["101.111.161.148/32"]
  
  # このルールを付与するセキュリティグループを設定
  security_group_id = aws_security_group.pub_a.id
}

####################
# APサーバーがWebサーバーからVPC内部IPを利用しSSHを受け入れるSG設定
####################
# APサーバーがWebサーバーからSSHを受け付けるSGの構築
resource "aws_security_group" "priv_a" {
  
  # セキュリティグループ名を設定
  name = "sg_priv_a"
  
  # セキュリティグループを構築するVPCのIDを設定
  vpc_id = aws_vpc.vpc.id
  
  # タグを設定
  tags = {
    Name = "sg-priv-a"
  }
}

# 出て行く通信の設定
resource "aws_security_group_rule" "egress_priv_a" {

  # このリソースが通信を受け入れる設定であることを定義
  # egressを設定
  type = "egress"
  
  # ポートの範囲設定
  # 全てのトラフィックを許可する場合いずれも0で設定
  from_port = 0
  to_port = 0
  

  # プロトコル設定
  # 以下は全てのIPv4トラフィックを許容する設定
  protocol = "-1"
  
  # 許可するIPの範囲を設定
  # 以下は全てのIPv4トラフィックを許容する設定
  cidr_blocks = ["0.0.0.0/0"]
  
  # このルールを付与するセキュリティグループを設定
  security_group_id = aws_security_group.priv_a.id
}

# SSHを受け入れる設定
resource "aws_security_group_rule" "ingress_priv_a_22" {

  # このリソースが通信を受け入れる設定であることを定義
  # ingressを設定
  type = "ingress"
  
  # ポートの範囲設定
  from_port = "22"
  to_port = "22"
  
  # プロトコルはtcpを設定
  protocol = "tcp"
  
  # 許可するIPの範囲を設定
  # Webサーバーを配置しているサブネットのCIDRを設定
  cidr_blocks = ["10.0.1.0/24"]
  
  # このルールを付与するセキュリティグループを設定
  security_group_id = aws_security_group.priv_a.id
}