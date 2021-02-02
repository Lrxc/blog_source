---
title: Ubuntu-Nginx-配置
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：ubuntu 18.04 LTS
- Nginx: 1.16.0

## 一  安装

1. 更新软件源
```
sudo apt update
```
2. 安装
```
sudo apt install nginx
```
3. 命令启动、停止、重启
```
service  nginx start|stop|reload
```
4. 外网访问
默认端口80
![image.png](https://upload-images.jianshu.io/upload_images/2803682-b94cc8f9679732ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 二  代理转发

 1. 配置代理

    sudo vim /etc/nginx/nginx.conf

    ```
    http {
        include       mime.types;
        default_type  application/octet-stream;
        sendfile        on;
        keepalive_timeout  65;
    
        server {
    		#监听端口
            listen       80;
    		#监听地址
            server_name  localhost;
    
            location / {
    			proxy_pass  http://localhost:8081;
            }
    		location /jian {
                proxy_pass  https://www.jianshu.com/;
            }
        }
    }
    ```

    代理说明：
    访问 http://localhost:80   实际是：https://localhost:8081
    访问 http://localhost/jian  实际是：https://www.jianshu.com
2. location正则写法

- 已=开头表示精确匹配
-  ^~ 开头表示uri以某个常规字符串开头，不是正则匹配
-  ~ 开头表示区分大小写的正则匹配;
-  ~* 开头表示不区分大小写的正则匹配
-  / 通用匹配, 如果没有其它匹配,任何请求都会匹配到

location正则详解：https://segmentfault.com/a/1190000002797606

3. proxy_pass 转发相对--绝对路径

   在nginx中配置proxy_pass时，当在后面的url加上了/，相当于是绝对根路径，则nginx不会把location中匹配的路径部分代理走;

   如果没有/，则会把匹配的路径部分也给代理走

   例：localhost/proxy/test.html 进行访问

   ```
   location  /proxy/ {
   	proxy_pass http://127.0.0.1:81/;
   }
   ```

   转发到：localhost/test.html 

   ```
   location  /proxy/ {
   	proxy_pass http://127.0.0.1:81; #少一个 /
   }
   ```

   转发到：localhost/proxy/test.html

4. 重启nginx服务

```
service nginx restart
```

访问 http://localhost/jian
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d8ac8dfe3a612108.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 三  卸载
**首先停止nginx 服务**

1. 删除nginx
```
apt --purge remove nginx
```
2. 自动移除全部不使用的软件包
```
apt autoremove
```
3. 列出与nginx相关的软件 并删除显示的软件
```
dpkg --get-selections|grep nginx

apt-get --purge remove nginx
```
