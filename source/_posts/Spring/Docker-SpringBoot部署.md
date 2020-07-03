---
title: Docker-SpringBoot部署
date: 2018-07-01 16:01:33
categories: Spring
tags: spring
---


#
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
# 复制文件到容器，并重命名
ADD spring-boot-docker-1.0.jar app.jar
# 容器启动后执行的命令
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
```
3. 构建docker镜像
```
# 格式：docker build -t 镜像名(:标签) DockerFile的相对位置
docker build -t springboot:0.0.1 .
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ab2e193e01239762.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
查看所有容器
![image.png](https://upload-images.jianshu.io/upload_images/2803682-8f3119f50df26aa4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 启动docker项目
```
docker run -d -p 8761:8761 springboot:0.0.1
```
输入docker ps 查看所有运行的docker项目
![image.png](https://upload-images.jianshu.io/upload_images/2803682-dac8de435a05ac5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4 浏览器访问spring项目即可
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7b393c4ae8a79ac5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
