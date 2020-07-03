---
title: expect-mysql
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

send_user "============================mysql repo start============================\n"
spawn rm mysql80-community-release-sles12-3.noarch.rpm
interact
spawn wget https://repo.mysql.com//mysql80-community-release-sles12-3.noarch.rpm
interact
spawn rpm -Uvh mysql80-community-release-sles12-3.noarch.rpm
interact
exec rpm --import /etc/RPM-GPG-KEY-mysql
exec zypper mr -d mysql80-community
exec zypper mr -e -G mysql-connectors-community
exec zypper mr -e -G mysql-tools-community
exec zypper mr -e -G mysql57-community
spawn zypper refresh
interact
send_user "============================mysql repo end============================\n"

send_user "============================mysql add start============================\n"
#方式一
spawn zypper install -y mysql-community-server 
interact

#方式二
#exec rm mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar
#spawn wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar
#interact
#exec mkdir pack
#exec tar -xvf mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar -C pack
#cd pack
#spawn zypper in -y mysql-community-common-5.7.28-1.sles12.x86_64.rpm
#interact
#spawn zypper in -y mysql-community-libs-5.7.28-1.sles12.x86_64.rpm
#interact
#spawn zypper in -y mysql-community-client-5.7.28-1.sles12.x86_64.rpm
#interact
#spawn zypper in -y mysql-community-server-5.7.28-1.sles12.x86_64.rpm
#interact
#方式二结束

spawn service mysql start
interact
spawn service mysql status
interact
send_user "============================mysql add end============================\n"

spawn rcSuSEfirewall2 stop
interact
spawn netstat -tunlp
interact

