---
title: Suse Nginx
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Suse
tags: [linux,suse]
---

<meta name="referrer" content="no-referrer" />


#### 配置源
	-- 添加源
	zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
	--更新
	zypper refresh
	-- 安装
	zypper in nginx

#### 启动：
	//成功后会有界面
	# nginx
	//开机自启
	systemctl enable nginx

#### 防火墙：
	1 放行端口
		$ vim /etc/sysconfig/SuSEfirewall2
		--加上端口(多个用逗号分开)
		FW_SERVICES_EXT_TCP=”22,80,8090″
	2. 启动、关闭、重启防火墙：
	    $ rcSuSEfirewall2 start/stop/restart

#### 远程访问：
    http://ip:80/
    -- 日志记录
    /var/log/nignx/
    -- vim /srv/www/htdocs/index.html
        <html>
        <body>
            <h1>nginx没有默认index</h1>
        </body>
        </html>

#### 代理转发：

    //sudo vim /etc/nginx/nginx.conf
    
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
代理说明：
访问 [http://localhost:80](https://links.jianshu.com/go?to=http%3A%2F%2Flocalhost%3A80) 实际是：[https://localhost:8081](https://links.jianshu.com/go?to=https%3A%2F%2Flocalhost%3A8081)
访问 [http://localhost/jian](https://links.jianshu.com/go?to=http%3A%2F%2Flocalhost%2Fjian) 实际是：[https://www.jianshu.com](https://www.jianshu.com/)