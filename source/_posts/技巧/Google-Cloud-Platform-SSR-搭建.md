---
title: Google-Cloud-Platform-SSR-搭建
date: 2017-07-01 16:01:33
categories: 技巧
tags: 技巧
---


- 需要国际信用卡
- Google账号

#一 注册账号
1. 注册GCP
https://cloud.google.com
![image.png](https://upload-images.jianshu.io/upload_images/2803682-9a402139a748ef0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 进入控制台

#二 创建实例
1. 左侧选择 Compute Engine — VM实例
2. 点击 创建
- 名称：随意
- 地区：建议asia-east1-c
- 机器类型：micro (微型便宜点...)
- 启动磁盘 – Ubuntu 16.04 LTS
- 防火墙：允许HTTP流量，允许HTTPS流量
![image.png](https://upload-images.jianshu.io/upload_images/2803682-b38673eec1646e15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#三 配置网络
1. 左侧导航 — 计算 — VPC网络 
2. 外部 IP 地址—类型改为静态(非必须操作)
- 名称：任意
![image.png](https://upload-images.jianshu.io/upload_images/2803682-842594da5791a6ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 创建防火墙
- 名称：任意
- 流量方向：入站/出站（入站必须创建）、
- 目标：网络中的所有实例
- 目标 IP 地址范围：0.0.0.0/0
- 协议和端口： 全部允许
![image.png](https://upload-images.jianshu.io/upload_images/2803682-958ad4968642b35e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#四. 配置SS以及BBR
1. 左侧选择 Compute Engine — VM实例——ssh——在浏览器窗口中打开
![image.png](https://upload-images.jianshu.io/upload_images/2803682-5c3aa14fdcfe8451.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 获取root权限：
```
sudo passwd root
```
3. 安装SSR（根据脚本提示来）：
3.1 方式一(推荐)：
```
//下载一键搭建ssr脚本（只需要执行一次，卸载ssr后也不需要重新执行）
git clone -b master https://github.com/flyzy2005/ss-fly
//安装
ss-fly/ss-fly.sh -ssr
//卸载
./shadowsocksR.sh uninstall
```
3.2 方式二：
```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh 2>&1 | tee shadowsocksR.log
```
4. 安装BBR加速
4.1 方式一(推荐)：
```
ss-fly/ss-fly.sh -bbr
```
4.2 方式二：
```
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
```
检测成功与否
```
sysctl net.ipv4.tcp_available_congestion_control
//出现如下成功
# net.ipv4.tcp_available_congestion_control = reno cubic bbr
```
## 五 安装 V2Ray(比ssr更安全)
#### 1. 官方教程：
  https://toutyrater.github.io/prep/install.html
#### 2. 三方脚本1
```
bash <(curl -s -L https://git.io/v2ray.sh)
```
#### 3. 三方脚本2. 有图形化界面
```
wget -N --no-check-certificate [https://raw.githubusercontent.com/FunctionClub/V2ray.Fun/master/install.sh](https://raw.githubusercontent.com/FunctionClub/V2ray.Fun/master/install.sh) && bash install.sh
```
