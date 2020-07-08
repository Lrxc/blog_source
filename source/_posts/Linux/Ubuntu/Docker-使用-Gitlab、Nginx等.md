---
title: Docker-使用-Gitlab、Nginx等
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---

<meta name="referrer" content="no-referrer" />


#安装环境及版本：
- 系统：ubuntu 18.04 LTS
- Gitlab: 最新版本 latest
- 镜像加速器：阿里云 https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors
- 安装 docker：https://www.jianshu.com/p/254aea65eb06

# 一 docker gitlab
1. 从 docker 的镜像仓库中下载 gitlab 社区版的镜像
```
docker pull gitlab/gitlab-ce:latest
```
2 启动gitlab
```
// publish  # 端口映射
// -p 宿主机端口：容器端口  # 开放容器端口到宿主端口
sudo docker run \
  --publish 443:443 --publish 80:80\
  --name gitlab \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```
参数说明
```
$ sudo docker run --detach \ #  -d # 后台运行
  --hostname gitlab.example.com \   # 设置主机名或域名
  --publish 443:443 --publish 80:80 \ # 本地端口的映射
  --name gitlab \     # gitlab-ce 的镜像运行成为一个容器，这里是对容器的命名
  --restart always \  # 设置重启方式，always 代表一直开启，服务器开机后也会自动开启的
  --volume /srv/gitlab/config:/etc/gitlab \   # 将 gitlab 的配置文件目录映射到 /srv/gitlab/config 目录中
  --volume /srv/gitlab/logs:/var/log/gitlab \ # 将 gitlab 的log文件目录映射到 /srv/gitlab/logs 目录中
  --volume /srv/gitlab/data:/var/opt/gitlab \ # 将 gitlab 的数据文件目录映射到 /srv/gitlab/data 目录中
  gitlab/gitlab-ce:latest  # 需要运行的镜像
```
3 浏览器访问：
查看是否启动成功
```
docker ps
```
输出内容如下：
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d61bfad5d9baeba8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后浏览器访问：宿主机ip(ubuntu ip):80
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1a2bb5eab9607aab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

参考：https://juejin.im/post/5cc1df885188252d6c43fd91
# 二 docker nginx
官网:https://www.runoob.com/docker/docker-install-nginx.html
1. 运行命令
```
// -d # 后台运行
// -p 宿主机端口：容器端口  # 开放容器端口到宿主端口
$ docker run -d -p 91:80 nginx
```
外网访问
http://docker宿主机ip:91
![image.png](https://upload-images.jianshu.io/upload_images/2803682-9f2e7e02b0a294a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 二 自定义docker镜像 DockerFile
1.新建DockerFile文件,输入内容
```
FROM nginx
RUN echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
```
2. 构建容器
```
//my 后面 有个空格和点
docker build -t nginx:my .
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-81a8fc846b6996b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 运行
```
docker run -d -p 92:80 nginx:my
```
4.浏览器访问：http://docker宿主机ip:92
![image.png](https://upload-images.jianshu.io/upload_images/2803682-44bdf2fefb9eea42.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
