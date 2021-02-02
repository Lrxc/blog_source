---
title: Suse Linux 12 Docker安装
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：
- 系统：SUSE Linux Enterprise Server 12 SP2
- Docker: 

#### 安装docker

```
//设置源
zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss

sudo zypper dist-upgrade
sudo zypper update
sudo zypper install docker
```

###### 启动docker

```
service docker start/stop/restart
//查看docker配置信息
docker info
```

###### 配置国内镜像

```shell
//1. 不存在则新建daemon.json
vim /etc/docker/daemon.json
//2. 内容是{}
{
	"registry-mirrors": ["https://4oekmmf9.mirror.aliyuncs.com"]
}
//3. 重启docker服务并查看
docker info
```

#### Ngixn

```
// -d # 后台运行
// -p 宿主机端口：容器端口  # 开放容器端口到宿主端口
$ docker run -d -p 91:80 nginx

访问：
http://ip:91/
```

#### Rabbitmq

```
 //搜索镜像
 docker search rabbitmq:management
 //下载
 docker pull rabbitmq:management
 //运行
 docker run -d -p 5672:5672 -p 15672:15672 --name rabbitmq rabbitmq:management
 访问：
 http://[宿主机IP]:15672
```

