---
title: Suse Linux 12 Http Socks5 SSR
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：SUSE Linux Enterprise Server 12 SP2
- TinyProxy: http

## 开源镜像

```
-- 网易开源镜像
zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
```

## TinyProxy

1. 安装

```
zypper in tinyproxy
```

2. 配置

```shell
#修改配置文件 vim /etc/tinyproxy.conf
Port 8888		#预设端口8888,可以更改
Allow 127.0.0.1	#设置允许连接的ip和网段，默认全都禁止，如果全注释掉，则表示允许所有连接
```

```shell
rcSuSEfirewall2 stop	#关闭防火墙
```

3. 启动

```
systemctl start tinyproxy.service
service tinyproxy restart
```

4. 使用

```
IE浏览器-Internet选项-连接-局域网设置-代理服务器
其他浏览器一般可以直接设置代理
```

## Socks5

1. 安装

   ```
   zypper in gcc openldap-devel pam-devel openssl-devel
   zypper in install gcc-c++ libstdc++-devel
   zypper in install binutils
   ```

   ```
   wget http://jaist.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
   
   tar xf ss5-3.8.9-8.tar.gz
   cd ss5-3.8.9
   ./configure 
   make && make install
   
   cd /etc/opt/ss5/
   cp ss5.conf ss5.conf.org
   ```

   

2. 配置

3. 启动

4. 使用
