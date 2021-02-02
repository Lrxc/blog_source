---
title: Android Adb Logcat 抓取日志
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


抓取指定报名的log保存电脑本地  
adb logcat | find "com.bxlt.cpic.main" >D:/hello.txt


抓取全部日志保存手机本地  
adb logcat -f /sdcard/log.txt
