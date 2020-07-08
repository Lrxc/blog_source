---
title: Suse SSR
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Suse
tags: [linux,suse]
---

<meta name="referrer" content="no-referrer" />


安装

```
sudo zypper addrepo http://download.opensuse.org/repositories/home:MargueriteSu/openSUSE_13.1/home:MargueriteSu.repo
sudo zypper refresh
sudo zypper install shadowsocks-libev
```

修改配置文件：

```
sudo vi /etc/shadowsocks/shadowsocks-libev-config.json
```

启动服务：

```
sudo systemctl start shadowsocks-libev-server@shadowsocks-libev-config
```

开机启动：

```
sudo systemctl enable shadowsocks-libev-server@shadowsocks-libev-config
```