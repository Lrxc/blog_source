---
title: Android RecyclerView-刷新闪屏
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


项目中遇到的，使用notifyDataSetChanged() 刷新闪屏问题，网上找资料说 
```
notifyItemRangeChanged(0, list.size())
```
试了下，确实可以，不过后来项目中加入Ndk又特么不行了。。。
后来又找资料，说什么动画问题，重写动画。。。麻烦的一塌糊涂啊

后来发现需要加上这句就行了
```
recyclerView.setItemAnimator(null);//设置动画为null来解决闪烁问题
```
完美解决。。。
