---
title: expect-minio
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
spawn zypper rr oss
interact
spawn zypper ar -f -G http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
interact
spawn zypper refresh
expect {
	"Do" {send "a\r"}
	"refreshed" {send "\r";send_user "repo install successed"}
}
interact
send_user "============================repo add end============================\n"

send_user "============================minio add start============================\n"
spawn rm minio
interact
spawn wget https://dl.min.io/server/minio/release/linux-amd64/minio
interact
exec chmod +x minio
exec rm -rf /usr/local/minio
exec mkdir /usr/local/minio
exec mkdir /usr/local/minio/data
exec cp minio /usr/local/minio
spawn nohup /usr/local/minio/minio server /usr/local/minio/data/
interact
send_user "============================minio add end============================\n"

spawn rcSuSEfirewall2 stop
interact
spawn netstat -tunlp
interact

