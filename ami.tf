####################
# AMI(Amazonマシンイメージ)の設定
####################
# AMIのData sources(データソース)を"amzn2"という名称で作成
data "aws_ami" "amzn2" {
  
  # 複数の結果が返された場合は、最新のAMIを使用
  most_recent = true
  
  # 検索を制限するAMI所有者のリスト
  # AWSアカウントIDやAWS所有者のエイリアスを設定可能
  # 以下はAWS所有者のエイリアスの例
  # ["amazon","aws-marketplace","microsoft"]
  # 今回はAmazon公式が配布してるAMIを指定するため、以下の値を設定
  owners = ["amazon"]
  
  # ひとつ以上のname(名前)とvalues(値)のペアで検索条件を設定
  filter {
    
    # 検索する属性を選択
	# AWSで公開されているイメージの名称からfilter
	name = "name"
	
	# イメージの名称のうち、以下にマッチするものを抽出
	# [*]は、ワイルドカード
	values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

