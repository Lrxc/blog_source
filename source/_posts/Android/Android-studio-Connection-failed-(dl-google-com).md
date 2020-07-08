---
title: Android-studio-Connection-failed-(dl-google-com)
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


公司的网，莫名其妙的不能更新了，却可以下载compile文件。。。
于是乎翻墙，hosts，修改studio.exe.vmoptions文件 然并卵，都特么不行 搞了一天还是不行

这种问题或许可以找到办法 但是如果下次是 Connection failed (xxxx.xxxx.com)该怎么办呢，授人以鱼不如授人以渔，同样，学人以鱼不如学人以渔，我们要的是下次遇到类似问题的解决能力，而不是一次的解决方案

入正题：
1.别管那个网站打开失败，记下来

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-03af6c1b37165f7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.百度 站长工具

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-b279361e2079fcd5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

打开这个 把失败的网站输进去

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-765fc13cb6abe7db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

相应时间越短越好，记下对应ip
3.打开C:\Windows\System32\drivers\etc，打开hosts文件，加入一行  
    203.208.40.142 dl.google.com  (可以试试直接复制这句到hosts)
   前面ip是刚才记下的，后面地址就是打不开的那个 中间空格 

保存后再次更新，完美解决
参考大神文章：http://blog.csdn.net/cswoniu111/article/details/52187840
