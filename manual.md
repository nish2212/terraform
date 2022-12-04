#terraform Tutorial
## AWSアカウントの作成


## AWS上でterraformユーザの作成

## 作業サーバにterraformユーザの作成
adduser terrafomer
usermod -aG sudo terraformer

## tfenv(terraform管理ツール)のインストール
https://qiita.co m/simis/items/19270c017c4193532f4d
su - terraformer
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
sudo ln -s ~/.tfenv/bin/* /usr/local/bin

## tfenvを利用したterraformのインストール
tfenv list-remote | head
tfenv install 1.3.6
tfenv list
tfenv use 1.3.6
tfenv list

cd /usr/local/bin
rm -f tfenv terraform
rm -rf ~/.tfenv


### raspiでは上記ダメだったので、直接terraformをインストール
cd /tmp
wget https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_arm.zip
unzip terraform_1.3.6_linux_arm.zip
mv terraform /usr/local/bin/.


## direnvのインストール
sudo apt-get update
sudo apt-get install -y direnv
direnv --version

## direnv設定でAWSへの簡易アクセス
cd
mkdir -p devtest/terraform
cd devtest/terraform

vi ~/.bash_profile
==
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
==

vi ~/.bashrc
==
eval "$(direnv hook bash)"
==

source ~/.bashrc

touch .envrc
vi .envrc
==
export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="xxx"
export AWS_REGION="xxx"
==

direnv allow

env | grep AWS

## githubクローン
cd ~/devtest/terraform
git clone https://github.com/nish2212/terraform.git


## VPC 作成
cd ~/devtest/terraform/terraform
vi vpc.tf
==
####################
# VPC設定
####################

# AWS上にVPCを構築
resource "aws_vpc" "vpc" {

  # ネットワークの範囲を設定
  cidr_block = "10.0.0.0/16"

  # タグを設定
  tags = {
    Name = "dev-vpc"
  }
}
==


## Terraform初回起動
cd ~/devtest/terraform/terraform
terraform init
terraform plan
terraform apply
terraform state list
terraform state show aws_vpc.vpc
terraform plan -destroy
terraform destroy

terraform plan -target=aws_vpc.vpc
terraform apply -target=aws_vpc.vpc
terraform state list
terraform state show aws_vpc.vpc

## サブネットの作成