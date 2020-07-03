---
title: expect
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Shell
tags: [linux,shell]
---


#set timeout 30

send_user "============================repo add start============================\n"
spawn zypper mr -d SLES12-SP2-12.2-0
interact
spawn zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
interact
spawn zypper refresh
expect {
	"Do" {send "t\r"}
	"refreshed" {send "\r";send_user "源已经安装了"}
}
interact
send_user "============================repo add end============================\n"

send_user "============================openjdk add start============================\n"
spawn zypper install -y java-1_8_0-openjdk
interact
spawn java -version
interact
send_user "============================openjdk add end============================\n"

send_user "============================nginx add start============================\n"
spawn zypper install nginx
expect {
	"Choose * number" {send "3\r"
			expect {
				"Continue" {send "y\r"}
			}
		}
	"already installed" {send "\r";send_user "nginx已经安装了"}
}
interact
spawn service nginx start
interact
send_user "============================nginx add end============================\n"

send_user "============================redis add start============================\n"
spawn zypper install -y redis
interact
spawn nohup redis-server
interact
send_user "============================redis add end============================\n"

send_user "============================rabbitmq add start============================\n"
spawn zypper in -y rabbitmq-server
interact
spawn zypper in -y rabbitmq-server-plugins
interact
spawn rabbitmq-plugins enable rabbitmq_management
interact
spawn rabbitmq-server -detached
interact
send_user "============================rabbitmq add end============================\n"

send_user "============================minio add start============================\n"
#spawn wget https://dl.min.io/server/minio/release/linux-amd64/minio
#interact
spawn chmod +x minio
spawn mkdir /usr/local/minio
spawn mkdir /usr/local/minio/data
spawn cp minio /usr/local/minio
interact
spawn nohup /usr/local/minio/minio server /usr/local/minio/data/
interact
send_user "============================minio add end============================\n"

spawn rcSuSEfirewall2 stop
interact
spawn netstat -tunlp
interact

