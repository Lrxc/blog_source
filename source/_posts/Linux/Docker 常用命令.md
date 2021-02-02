---
title: Docker 常用命令
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


---

---

<!-- -->



## 镜像加速器

修改daemon配置文件/etc/docker/daemon.json来使用加速器

```
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://4oekmmf9.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

阿里加速:https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors

## 一 镜像

下载官方镜像

```
docker pull nginx
```

自定义构建镜像

```
#格式：docker build -t 镜像名(:标签) Dockerfile的位置
docker build -t springboot:0.0.1 .
```

导入导出镜像，导出一个是镜像ID，一个是容器ID。导入都是镜像

```
#导出是镜像ID(推荐)
docker save >/temp/my.tar nginx:latest	#nginx:latest=>镜像ID:标签
docker load </temp/my.tar

#导出是容器ID(镜像被删除的情况，或则容器有修改的情况)
docker export >/temp/my.tar 24db3058414e	#24db3058414e=>容器ID
docker import /temp/my.tar nginx:0.0.1		#nginx:3.6.3=>标注镜像名(:标签)
```

删除镜像

```
#查看所有镜像
docker images
#删除之前必须停止并删除其容器
docker rmi 镜像ID
```

## 二 容器

构建容器

```
#-d: 后台运行容器，并返回容器ID
#-p: 指定端口映射，格式为：主机(宿主)端口:容器端口
#--name="demo": 为容器指定一个名称
#-v: 映射主机目录到容器,格式为：主机(宿主)路径:容器路径

#springboot:0.0.1 ==》 镜像名(:标签)，
docker run -d -p 8080:8080 springboot:0.0.1
docker run -d -p 8090:8080 --name demo -v /root/log:/log springboot:0.0.1
```

启动停止容器

```
docker start/stop/restart 容器ID/容器名称

#查看运行中容器
docker ps 
#查看所有容器
docker ps -a
#查看指定容器的详细状态
docker top 容器ID/容器名称
```

进入容器内部

```
#不同机器略有不同，以下三种都试试
docker exec -it 容器ID/容器名称 /bin/bash
docker exec -it 容器ID/容器名称 bash
docker exec -it 容器ID/容器名称 sh

#退出容器
exit
```

删除容器

```
#查看所有容器
docker ps -a
#删除容器
docker rm -f 容器ID/容器名称
```

查看容器运行日志

```
docker logs -f 容器ID/容器名称
```

