---
title: sh-minio
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Shell
tags: [linux,shell]
---

<meta name="referrer" content="no-referrer" />


echo "============================minio add start============================\n"
# rm minio
# wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x data/minio;
rm -rf /usr/local/minio;
mkdir -p /usr/local/minio/data;
cp data/minio /usr/local/minio;
chmod -R 777 /usr/local/minio;
# 启动
nohup /usr/local/minio/minio server /usr/local/minio/data/ &
echo "============================minio add end============================\n"

rcSuSEfirewall2 stop;
netstat -tunlp;

