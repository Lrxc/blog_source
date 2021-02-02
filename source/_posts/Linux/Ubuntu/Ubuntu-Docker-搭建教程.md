---
title: Ubuntu-Docker-搭建教程
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


#安装环境及版本：
- 系统：ubuntu 18.04 LTS
- Dcoker: 



# 一 安装

### 方式1 阿里云源

```js
# step 1: 安装必要的一些系统工具
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
sudo apt-get -y update
sudo apt-get -y install docker-ce
```



### 方式2 脚本

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```



### 方式3 apt命令

##### 1 设置存储库
1. 更新apt包索引
```
$ sudo apt-get update
```
2. 安装包以允许apt通过HTTPS使用存储库：
```
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```
3. 添加Docker的官方GPG密钥：
```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
4. 使用以下命令设置稳定存储库
```
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```
##### 2 安装DOCKER CE
1. 更新apt包索引。
```
$ sudo apt-get update
```
2. 安装最新版本的Docker CE和containerd，或者转到下一步安装特定版本：
```
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```
3. 通过运行hello-world 映像验证是否正确安装了Docker CE 
```
$ sudo docker run hello-world
```
# 二 常用命令

```
// 启动 停止 重启 docker服务
$ sudo service docker start|stop|restart

// docker 命令
docker search 关键字 eg：docker search redis，检索镜像(一般从docker hub检索)
docker pull 镜像名:tag 拉去镜像
docker images 镜像列表
docker container ls  列表所有的容器
docker rmi image-id 删除指定镜像
docker rm container-id 删除指定容器
docker ps 查看运行中的容器 -a 查看所有容器
docker start/stop container-id||container-name 开启/停止 指定容器id或者容器名称的容器
docker version 版本信息
```

# 国内镜像

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



# 三 卸载
1. 卸载Docker CE软件包：
```
$ sudo apt-get purge docker-ce
```
2. 主机上的图像，容器，卷或自定义配置文件不会自动删除。要删除所有图像，容器和卷：
```
$ sudo rm -rf /var/lib/docker
```

#附件 
官方教程：https://docs.docker.com/install/linux/docker-ce/ubuntu/
阿里教程：https://yq.aliyun.com/articles/110806?spm=5176.8351553.0.0.74621991Vgp3xS
