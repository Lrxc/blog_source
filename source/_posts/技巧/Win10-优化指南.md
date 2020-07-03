---
title: Win10-优化指南
date: 2017-07-01 16:01:33
categories: 技巧
tags: 技巧
---


 1. 关闭不必要服务
* Connected User Experiences and Telemetry：用于收集错误信息，对于硬盘消耗较大，是很多低配电脑卡顿的元凶。

* Diagnostic Execution Service：诊断执行服务，用以执行故障诊断支持的诊断操作，效果类似Connected User Experiences and Telemetry。

* SysMain：即以前的SuperFetch，对于机械硬盘有一定作用，但固态硬盘作用不大，而且常常是导致CPU占用飙升100%的元凶。如果用户使用的是SSD，且物理内存较大，可以考虑关闭。

* Windows Search：Windows搜索服务，作用是实现文件的快速搜索。不过这是一项经常在系统后台”查水表”的服务，很多时候电脑待机时硬盘灯长亮就是它的“功劳”。此外Win10新版中的“活动历史记录”也依赖于该服务。如果安装的是SSD，且对“活动历史记录”无感可以考虑关闭，尤其对于低配电脑，性能提升非常明显。

2 关闭DIPM节能机制
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2e3279eb27e66c9a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 关闭系统保护
4. 关闭Windows Defender
5. 关闭“快速启动”
