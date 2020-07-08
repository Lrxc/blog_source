---
title: sh-mysql
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Shell
tags: [linux,shell]
---

<meta name="referrer" content="no-referrer" />


echo "====================gcc & gcc-c++ install====================";
rpm -ivh data/gcc/*.rpm;
rpm -ivh data/gcc/*/*.rpm;
echo "============================mysql add start============================\n"
mkdir pack;
tar -xvf data/mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar -C pack;
cd pack;
rpm -ivh mysql-community-common-5.7.28-1.sles12.x86_64.rpm;
rpm -ivh mysql-community-libs-5.7.28-1.sles12.x86_64.rpm;
rpm -ivh mysql-community-client-5.7.28-1.sles12.x86_64.rpm;
rpm -ivh mysql-community-server-5.7.28-1.sles12.x86_64.rpm;
#启动
service mysql start;
service mysql status;
# 查看初始密码
grep 'temporary password' /var/log/mysql/mysqld.log;
echo "============================mysql add end============================\n"

rcSuSEfirewall2 stop;
netstat -tunlp;

