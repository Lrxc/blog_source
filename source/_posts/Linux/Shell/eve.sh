---
title: eve
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Shell
tags: [linux,shell]
---

<meta name="referrer" content="no-referrer" />


echo "----------------------------repo add start----------------------------"
zypper mr -d SLES12-SP2-12.2-0;
zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss;
zypper refresh;
echo "----------------------------repo add end----------------------------"

echo "----------------------------nginx add start----------------------------"
zypper install -y nginx;
service nginx start;
echo "----------------------------nginx add end----------------------------"

echo "----------------------------redis add start----------------------------"
zypper install -y redis;
service redis start;
echo "----------------------------redis add end----------------------------"

echo "----------------------------openjdk add start----------------------------"
zypper install -y java-1_8_0-openjdk;
java -version;
echo "----------------------------openjdk add end----------------------------"

echo "----------------------------rabbitmq add start----------------------------"
zypper install -y rabbitmq-server;
zypper install -y rabbitmq-server-plugins;
rabbitmq-plugins enable rabbitmq_management;
rabbitmq-server -detached;
echo "----------------------------rabbitmq add end----------------------------"

echo "----------------------------minio add start----------------------------"
#wget https://dl.min.io/server/minio/release/linux-amd64/minio;
chmod +x minio;
mkdir /usr/local/minio;
mkdir /usr/local/minio/data;
mv minio /usr/local/minio;
/usr/local/minio/minio server /usr/local/minio/data/ &;
echo "----------------------------minio add end----------------------------"

netstat -tunlp