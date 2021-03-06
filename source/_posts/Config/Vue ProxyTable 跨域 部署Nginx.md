---
title: Vue ProxyTable 跨域 部署Nginx
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


说明：proxyTable 只是前端开发调试时有效，真正的转发需要Nginx。

**整体流程：**
前端地址：10.10.3.120:8080  后端地址:10.10.3.120:8082
vue请求 10.10.3.120:8080/api/login --> nginx得到/api/login-->nginx转发到10.10.3.120:8082/api/login
**也就是说，这个过程和proxyTable 的转发没关系了。**

## Vue前端配置
#### 1 vue proxtTable 配置
```
  dev: {
    port: 80,
    assetsSubDirectory: 'static', //打包后生成的路径名
    assetsPublicPath: '/',
    proxyTable: {
      '/api': {
        target: 'http://10.10.3.120:8082', //服务器ip地址
        changeOrigin: true,    // 是否跨域
        pathRewrite: {  //pathRewrite可以不加
          '^/api': '/api'   // 这种接口配置出来     http://10.10.3.120:8082/api/login
          '^/api': '/'        // 这种接口配置出来      http://10.10.3.120:8082/login
        }
      }
    }
  }
```
 请求使用
```
       // 登录
      login(){
        this.$ajaxget({
          url: '/api/login',
          data: {},
          successFc: data => {
            console.log(data.data)
          }
        })
      },
```
#### 2 打包上传，不需要特殊修改代码
打包好的代码位于dist目录下，上传dist文件夹到服务器指定路径
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1435266efc15e819.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Nginx 配置
#### 1 配置nginx.conf
```
http {
	//xxx
	//xxx
	
    #前端代理
    server {
        listen 8080;
        server_name localhost;
        location /{
            root   /var/www/dist/;   #前端代码存放地址
            index  index.html index.htm;
        }
        #前端proxyTable(重点)
        location /api/ {  #此名称api对应vue的proxyTable名称
            proxy_pass http://10.10.3.120:8082/; #对应proxyTable的target地址
        }
    }
}
```
ngnx转发超时（org.apache.catalina.connector.ClientabortException:java.io.IOException:Broken pipe）

```
#代理转发超时配置(broken pipe错误)
proxy_send_timeout 1200s;
proxy_read_timeout 1200s;
proxy_connect_timeout 1200s;
send_timeout 1200s;
```

#### 2 启动nginx

```
service nginx start
```
#### 3 访问
```
http://10.10.3.120:8080
```



## 转发地址

```
假设下面四种情况分别用 http://192.168.1.1/proxy/test.html 进行访问。

第一种：
location /proxy/ {
proxy_pass http://127.0.0.1/;
}
代理到URL：http://127.0.0.1/test.html

第二种（相对于第一种，最后少一个 / ）
location /proxy/ {
proxy_pass http://127.0.0.1;
}
代理到URL：http://127.0.0.1/proxy/test.html

第三种：
location /proxy/ {
proxy_pass http://127.0.0.1/aaa/;
}
代理到URL：http://127.0.0.1/aaa/test.html

第四种（相对于第三种，最后少一个 / ）
location /proxy/ {
proxy_pass http://127.0.0.1/aaa;
}
代理到URL：http://127.0.0.1/aaatest.html

```

