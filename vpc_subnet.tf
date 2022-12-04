####################
# Webサーバー用Public Subnet
####################
# ap-northeast-1aのAvaliabilityZoneにWebサーバー用のサブネットを構築
resource "aws_subnet" "public_a" {

  # サブネットを構築するVPCのIDを設定
  # [vpc.tf]で記述詩たVPCを変数で指定
  vpc_id = aws_vpc.vpc.id
  
  # サブネットが使用するcidrを設定
  # VPCの範囲内でSubnetに割り当てるCIDRを区切る
  cidr_block = "10.0.1.0/24"
  
  # サブネットを配置するAvaliabilityZoneを東京リージョン1aに設定
  availability_zone = "ap-northeast-1a"
  
  # このサブネットで起動したインスタンスにパブリックIPを割り当てる
  map_public_ip_on_launch = true
  
  # タグを設定
  tags = {
    Name = "pub-a"
  }
}


####################
# APサーバー用Private Subnet
####################
# ap-northeast-1aのAvailabilityZoneにAPサーバー用のサブネットを構築
resource "aws_subnet" "private_a" {
  # サブネットを構築するVPCのIDを設定
  # [vpc.tf]にて記述したVPCを変数で指定
  vpc_id = aws_vpc.vpc.id
  
  # サブネットが使用するcidrを設定
  # VPCの範囲内でSubnetに割り当てるCIDRを区切る
  cidr_block = "10.0.2.0/24"
  
  # サブネットを配置するAvailabilityZoneを東京リージョン1aに設定
  availability_zone = "ap-northeast-1a"
  
  # タグを設定
  tags = {
  Name = "priv-a"
  }
}