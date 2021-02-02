---
title: SpringBoot-Docker部署
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


##环境及版本：

- Docker：
- Maven:  
- Jdk:

打包的环境必须有docker环境



1. 新建springboot项目,不需要额外依赖
```
@SpringBootApplication
@RestController
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

    @RequestMapping("/show")
    public Object show() {
        return "Hello Docker";
    }
}
```
2. 打jar包 'spring-boot-docker-1.0.jar'，并上传至服务器
2. 在jar包所在目录，新建文件'DockerFile',内容如下：
```
# 基于那个镜像，本地不存在将会从 DockerHub 下载
FROM openjdk:8-jdk-alpine
#在宿主机的/var/lib/docker目录下创建一个临时文件并把它链接到tomcat容器的工作目录/tmp目录
VOLUME /tmp
# 复制文件到容器，并重命名(需修改自己app名称)
ADD spring-boot-docker-1.0.jar app.jar
# 容器启动后执行的命令
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
```
3. 构建docker镜像
```
# 格式：docker build -t 镜像名(:标签) Dockerfile的相对位置
docker build -t springboot:0.0.1 .
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ab2e193e01239762.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
查看所有镜像
![image.png](https://upload-images.jianshu.io/upload_images/2803682-8f3119f50df26aa4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. 构建容器并启动docker项目
```
#-d: 后台运行容器，并返回容器ID
#-p: 指定端口映射，格式为：主机(宿主)端口:容器端口
#--name="demo": 为容器指定一个名称
#-v: 映射主机目录到容器,格式为：主机(宿主)路径:容器路径

#springboot:0.0.1 ==》 镜像名(:标签)，
docker run -d -p 8080:8080 springboot:0.0.1
docker run -d -p 8090:8080 --name demo -v /root/log:/log springboot:0.0.1
```
输入docker ps 查看所有运行的docker项目
![image.png](https://upload-images.jianshu.io/upload_images/2803682-dac8de435a05ac5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4 浏览器访问spring项目即可
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7b393c4ae8a79ac5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)