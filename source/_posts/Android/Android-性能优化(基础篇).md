---
title: Android-性能优化(基础篇)
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


1 if else switch case 效率
```
if else：小场景
switch case：分支语句较多
```
2 setimageresource vs setimagedrawable
```
 setImageResource：这会在UI线程上进行 Bitmap读取和解码，这会导致延迟
```
