---
title: MacBook Pro 2018 U盘重装系统
date: 2017-07-01 16:01:33
categories: MacOS
tags: macos
---

<meta name="referrer" content="no-referrer" />


##　参数配置

- mbp 2018 
- Ｕ盘16G

## 一 制定启动盘

- 官方教程：https://support.apple.com/zh-cn/HT201372

1. 应用商店下载需要的MacOS，下载成功后不需要点击安装

2. 插入U盘，格式化为 Mac OS 扩展格式，名字对应下面的 **MyVolume**

![image.png](https://upload-images.jianshu.io/upload_images/2803682-895acf29deecfa9d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 制作启动盘，终端执行以下命令

   **Catalina**

   ```
   sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
   ```

   **Mojave**

   ```
   sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
   ```

   **High Sierra**

   ```
   sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
   ```

   

   <img src="https://support.apple.com/library/content/dam/edam/applecare/images/en_US/macos/Big-Sur/macos-big-sur-terminal-create-bootable-installer.jpg" style="zoom: 67%;" />

## 二 设置Secure Boot(安全启动)
1. 开机 Command (⌘)-R，菜单栏中选取“实用工具”>“启动安全性实用工具”。选择无安全性、允许从外部介质安装
   ![image.png](https://upload-images.jianshu.io/upload_images/2803682-e1d6fd137f66ecc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   官方教程：https://support.apple.com/zh-cn/HT208198

## 三 开始安装
1. 开机按option，选择U盘，下一步即可

2. 安装旧版MacOS报错

   ```
   1. 先关闭电脑的网络, 如关闭右上角的WIFI或者拔掉网线
   2. 终端里面修改时间
   date 122014102015.30
   上面的办法修改后还是不行，那么输入下面的代码试试
   date 062614102014.30
   ```

## 四 在线恢复模式

1. Command (⌘)-R 当前系统版本
2. Option-Command-R 安装最新版本
3. Shift-Option-Command-R  安装出厂版本

以上三种恢复模式，关机后按下组合键，即可进入小地球页面，连上wifi，自动恢复即可开始

```
在线恢复失败：
自动进入恢复模式(小地球)，连接WiFi没反应，等会报错2002或其他各种失败问题
解决方法：当前wifi有问题，切换wifi，或者手机开个热点就行了
```

## 附录：MacOS原版镜像下载

#### macOS Big Sur 11.0.1（20B29）

```
http://s1.mac2x.com/macos/11.0.x/Install.macOS.Big.Sur.11.0.1.20B29.16.1.03.dmg
```
#### macOS Catalina 10.15.7 (19H2)：

```
http://s1.mac2x.com/macos/10.15.x/Install.macOS.Catalina.10.15.7.02.19H2.dmg
```

#### macOS Mojave 10.14.6 (18G103)：

```
magnet:?xt=urn:btih:daa09898b2764c9a513aee76c67d9f27c9ec6159
```

#### macOS High Sierra 10.13.6 (17G2208):

```

```