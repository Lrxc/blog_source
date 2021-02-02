---
title: Ubuntu-Gitlab-社区版搭建
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：ubuntu 18.04 LTS
- Gitlab: 最新版本 latest

##一  安装并配置必要的依赖项
```
sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates
```
##二 添加GitLab软件包存储库并安装软件包
添加GitLab包存储库
```
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
```
安装GitLab包。并设置gitlab访问地址为'https://localhost'
```
sudo EXTERNAL_URL="https://localhost" apt-get install gitlab-ce
```
##三 编辑GitLab配置文件
1 修改GitLab默认访问地址,上一步已经制定了访问地址，此处可修改
```
$ sudo vim /etc/gitlab/gitlab.rb

// 将external_url  地址改成本地
// external_url 'http://localhost'
```

2 保存，更新配置
```
sudo gitlab-ctl reconfigure
```
##四 启动
```
sudo gitlab-ctl start/stop
```
外网访问 http://192.168.234.134/80 （192.168.234.134为ubuntu的ip）
在您第一次访问时，您将被重定向到密码重置屏幕。提供初始管理员帐户的密码，您将被重定向回登录屏幕。使用默认帐户的用户名root登录
## 设置镜像加速器
 下载镜像慢问题，比如gitlab、nginx。。
1 登录阿里云平台，找到 容器镜像服务
阿里云平台： https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e75ab7b9032053ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

附录：
官网安装地址：https://about.gitlab.com/install/#ubuntu
其他安装方案：https://www.howtoing.com/how-to-install-and-configure-gitlab-on-ubuntu-18-04
