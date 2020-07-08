---
title: Google
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


修改root密码

```
sudo passwd root
ssh
```

修改远程ssh

```
//修改 vim /etc/ssh/sshd_config 
//拒绝登录
PermitRootLogin yes
//使用密码
PasswordAuthentication yes
```

```
service ssh restart
reboot
```

图形脚本

https://github.com/sprov065/v2-ui

```
bash <(curl -Ls https://blog.sprov.xyz/v2-ui.sh)
```

命令脚本

https://github.com/233boy/v2ray/wiki/V2Ray%E6%90%AD%E5%BB%BA%E8%AF%A6%E7%BB%86%E5%9B%BE%E6%96%87%E6%95%99%E7%A8%8B

```
bash <(curl -s -L https://git.io/v2ray.sh)
```

