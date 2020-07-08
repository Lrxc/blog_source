---
title: Android--AlertDialog--设置确定不取消
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


AlertDialog 点击空白处可以取消，点击确定、取消按钮也会取消，但是有些场景不需要取消的。。
空白处取消设置setCancelable(false) 即可 但是确定、取消按钮还是可以取消

方法如下

```
AlertDialog show = new AlertDialog.Builder(MainActivity.this)
        .setTitle("提示").setMessage("不能打开").setCancelable(false)
        .setPositiveButton("确定", null).show();
//点击确定按钮不消失(必须在show方法之后)
show.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener(null);
```



![GIF.gif](http://upload-images.jianshu.io/upload_images/2803682-83a5f2d16aa2b17a.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
