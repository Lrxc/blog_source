---
title: Fiddler-手机远程调试
date: 2017-07-01 16:01:33
categories: 技巧
tags: 技巧
---

<meta name="referrer" content="no-referrer" />


一 Fiddler下载 
官网 https://www.telerik.com/fiddler

二 配置Fiddler
1 远程调试打开
![image.png](https://upload-images.jianshu.io/upload_images/2803682-b40c8c21349a98fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 监控https 默认不监控
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c1ee6596fee3be52.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 配置后一定重启Fiddler
4 电脑运行cmd 输入ipconfig  拿到本机ip  

三 手机配置
1. 保证电脑和手机处于同一局域网(电脑直接共享wifi给手机)
2. 连上对应wifi 设置wifi代理为手动
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6ebda519e93d3d91.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
主机名就是电脑ip，端口默认8888
3. 手机浏览器浏览内容。 Fiddler已经监控到了。

四 指定域名过滤
![image.png](https://upload-images.jianshu.io/upload_images/2803682-54d1b6fd92bc8418.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
1 显示指定域名
2 配置域名，多个英文 ; 分开
3 应用过滤条件



