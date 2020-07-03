---
title: 微信小程序scroll-view占满剩余屏幕
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---


思路：使用flex布局

一 wxml 代码
```
<view style="display:flex;flex-direction:column;height:100%">
  <text style="background:green">测试</text>

  <scroll-view scroll-y="true" style="background:red;flex:1;height:0;">
    <view wx:for="{{list}}" wx:key="{{index}}">
      <text>{{item}}\n\n\n</text>
    </view>
  </scroll-view>
</view>
```
二 wxss 代码
```
page{
  width:100%;
  height: 100%;
}
```

三 js 中的data添加一点数据
```
 data: {
    list: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  },
```

效果如下:
保持上面布局(测试那个)不动，下面可以滚动
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1cdbac9b73e72653.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6b747574be4b4a31.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



