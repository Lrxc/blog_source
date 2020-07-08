---
title: MacBook-Pro-2018-抹盘重装
date: 2017-07-01 16:01:33
categories: MacOS
tags: macos
---

<meta name="referrer" content="no-referrer" />


配置如下：mbp 2018 MoJave

一 制定启动盘
1 应用商店下载Mojave
2 插入U盘，格式化为 Mac OS 扩展格式，名字对应下面的AAA
```
//macOS High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/AAA --applicationpath /Applications/Install\ macOS\ High\ Sierra.app --nointeraction
//macOS Mojave 
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/AAA /Applications/Install\ macOS\ Mojave.app --nointeraction
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-895acf29deecfa9d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
官方教程：https://support.apple.com/zh-cn/HT201372
二 设置Secure Boot(安全启动)
1 开机 Command (⌘)-R，菜单栏中选取“实用工具”>“启动安全性实用工具”。选择无安全性、允许从外部介质安装
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e1d6fd137f66ecc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
官方教程：https://support.apple.com/zh-cn/HT208198
三 开始安装
1 开机按option，选择U盘，下一步即可

救砖说明：
Command +Option+R 自动进入恢复模式(小地球)，连接WiFi没反应，等会报错2002。
解决方法，电脑下载360WiFi共享热点即可
原贴https://blog.csdn.net/Code_LT/article/details/70949133

四 U盘安装旧版报错
```
1. 先关闭电脑的网络, 如关闭右上角的WIFI或者拔掉网线
2. 终端里面修改时间
date 122014102015.30
上面的办法修改后还是不行，那么输入下面的代码试试
date 062614102014.30
```
