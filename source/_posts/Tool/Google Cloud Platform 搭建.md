---
title: Google Cloud Platform 搭建
date: 2020-07-01 16:01:33
categories: Tool
tags: tool
---

<meta name="referrer" content="no-referrer" />


# 准备
- 需要国际信用卡(visa/master)

- Google账号

- 2020年11月有效

  

# 一 注册账号

1. 注册GCP
https://cloud.google.com
![image.png](https://upload-images.jianshu.io/upload_images/2803682-9a402139a748ef0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 进入控制台

# 二 创建实例
1. 左侧选择 Compute Engine — VM实例
2. 点击 创建 
	- 名称：随意
    - 地区：建议asia-east1-c
    - 机器类型：micro (微型便宜点...)
    - 启动磁盘 – Ubuntu 16.04 LTS
    - 防火墙：允许HTTP流量，允许HTTPS流量

![image.png](https://upload-images.jianshu.io/upload_images/2803682-b38673eec1646e15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
# 三 配置网络
1. 左侧导航 — 计算 — VPC网络 
2. 外部 IP 地址—类型改为静态(非必须操作)
- 名称：任意
![image.png](https://upload-images.jianshu.io/upload_images/2803682-842594da5791a6ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 创建防火墙
    - 名称：任意
    - 流量方向：入站/出站（入站必须创建）
    - 目标：网络中的所有实例
    - 目标 IP 地址范围：0.0.0.0/0
    - 协议和端口： 全部允许
  ![image.png](https://upload-images.jianshu.io/upload_images/2803682-958ad4968642b35e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



# 四. 远程连接

1. 打开ssh远程

左侧选择 Compute Engine — VM实例——ssh——在浏览器窗口中打开

![image.png](https://upload-images.jianshu.io/upload_images/2803682-5c3aa14fdcfe8451.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 获取root权限：
```shell
sudo passwd root	#设置root密码
su					#切换root用户
```
3. 本地工具连接服务器(用不到可跳过)

```shell
#修改 vim /etc/ssh/sshd_config 
PermitRootLogin yes			#root账号拒绝登录
PasswordAuthentication yes	#使用密码登录
service ssh restart			#重启ssh服务
```

4. 测试本地到服务器的速度(用不到可跳过)

```
wget https://raw.githubusercontent.com/oooldking/script/master/superspeed.sh
chmod +x superspeed.sh
./superspeed.sh
```

# 五. 配置科学上网

## 1. V2Ray
1. 官方教程：
   https://toutyrater.github.io/prep/install.html

2. 脚本1: 命令行

   官网：https://github.com/233boy/v2ray/wiki
   
   ```
   bash <(curl -s -L https://git.io/v2ray.sh)
   ```

3. 脚本2：有图形化界面

   官网：https://github.com/sprov065/v2-ui
   
   ```
   bash <(curl -Ls https://blog.sprov.xyz/v2-ui.sh)
   ```
   
   ```
   页面访问地址: http://xxx:65432    
   用户密码: admin/admin
   ```

## 2. BBR加速

1. 四合一脚本

   ```
   wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
   ```
   - 先在[1 – 3]切换内核（第一次显示为bbr内核也要切换一遍），重启

     中间有 Abort kernel removal? 界面，选no

   - 安装加速管理

   - 查看状态  ./tcp.sh

   