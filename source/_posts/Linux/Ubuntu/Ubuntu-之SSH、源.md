---
title: Ubuntu-之SSH、源
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---


## 一 SSH远程服务

1 Ubuntu安装SSH服务

```
//修改root密码
# sudo paswd root
```
```
//安装ssh服务
# sudo apt-get install openssh-server 
##查询ssh进程是否启动成功
# ps -e | grep ssh 
##重新启动ssh服务
# sudo /etc/init.d/ssh restart 
# sudo service ssh restart
//查看IP ssh连接即可
# ifconfig
```
2  错误：ssh 服务器拒绝了密码

```
//修改 vim /etc/ssh/sshd_config   被注释掉时，将注释全部释放就可以
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
PasswordAuthentication yes
```
3. 更新配置
```
# source /etc/ssh/sshd_config
```
4. 修改密码
```
//设置root密码
sudo passwd root 
```
## 二 安装shadowsocks 服务
1 安装ss

```
# sudo apt install shadowsocks ##安装ss

//python 版本
# sudo apt-get update
# sudo apt-get install python-gevent python-pip
# sudo pip install shadowsocks
# apt-get install python-m2crypto
```
2 配置服务器参数
```
# vim /etc/shadowsocks.json
{
"server":"0.0.0.0", #你的服务器IP
"server_port":8388,
"local_port":1080,
"password":"YourPwdForSS", #你的服务器密码
"timeout":600,
"method":"aes-256-cfb"
}
```
3 启动/关闭服务
```
//开启
# sudo ssserver -c /etc/shadowsocks.json -d start 
//关闭
# sudo ssserver -c /etc/shadowsocks.json -d stop
```
4  ss客户端 https://github.com/shadowsocks/shadowsocks-windows

填写信息:
服务器地址，端口号，密码，加密方式与代理端口默认即可。
右键任务栏图标，选择启用系统代理 Go

## 三 镜像源切换
1 备份官方源
```
# cp /etc/apt/sources.list /etc/apt/sources.list.bak
```
2. 添加镜像源
阿里云
```
//命令  vim /etc/apt/sources.list 
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```
清华大学
```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```
3. 更新即可
```
# sudo apt-get update
```

##四，关于ubunut 静态ip配置
  1 ubuntu 18
```
# sudo vim /etc/netplan/xx_config.yaml
addresses:
        - x.x.x.x/24
//保存退出。应用
# sudo netplan apply
```
原内容
![image.png](https://upload-images.jianshu.io/upload_images/2803682-3d7d3ec3e4378950.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

改后
![image.png](https://upload-images.jianshu.io/upload_images/2803682-943e6bdcba4de14f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


