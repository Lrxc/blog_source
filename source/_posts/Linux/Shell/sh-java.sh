---
title: sh-java
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
#
#
echo "====================jre install===================="
rpm -ivh data/jre-8u251-linux-x64.rpm;
java -version;
#
#
echo "====================redis install===================="
rpm -ivh data/redis-4.0.11-lp151.1.1.x86_64.rpm;
nohup redis-server &
#
#
echo "====================nginx install===================="
rpm -ivh --force --nodeps data/nginx/GeoIP-data-1.6.12-lp151.1.3.noarch.rpm;
rpm -ivh --force --nodeps data/nginx/libopenssl1_1-1.1.0i-lp151.7.7.x86_64.rpm;
rpm -ivh --force --nodeps data/nginx/libGeoIP1-1.6.12-lp151.1.3.x86_64.rpm;
rpm -ivh --force --nodeps data/nginx/nginx-1.14.0-lp151.3.3.x86_64.rpm;
rpm -ivh --force --nodeps data/nginx/GeoIP-1.6.12-lp151.1.3.x86_64.rpm;
service nginx start;
#
#
echo "====================rabbitmq install===================="
# rpm -ivh --force --nodeps erlang-20.3.8.25-1.el7.x86_64.rpm
# rpm -ivh --force --nodeps rabbitmq-server-3.7.14-1.suse.noarch.rpm
# 2== rabbitmq rpm
rpm -ivh --force --nodeps data/rabbitmq/libncurses6-6.1-lp151.5.41.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/libopenssl1_1-1.1.0i-lp151.7.7.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/libreadline7-7.0-lp151.9.53.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/libpq5-10.6-lp151.1.4.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/unixODBC-2.3.6-lp151.2.3.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/socat-1.7.3.2-lp151.4.3.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/psqlODBC-10.01.0000-lp151.2.3.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/erlang-20.3.8.15-lp151.2.33.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/erlang-epmd-20.3.8.15-lp151.2.33.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/rabbitmq-server-3.7.14-lp151.1.9.x86_64.rpm;
rpm -ivh --force --nodeps data/rabbitmq/rabbitmq-server-plugins-3.7.14-lp151.1.9.x86_64.rpm;
rabbitmq-plugins enable rabbitmq_management;
rabbitmq-server -detached;
# 启动\停止\状态 rabbitmqctl start_app/stop/status
# 卸载 rpm -e rabbitmq-server \ rpm -e rabbitmq-server-plugins
#
#
rcSuSEfirewall2 stop;
netstat -tunlp;