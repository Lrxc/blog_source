---
title: Android_自定义Dialog底部弹出动画
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


效果图如下
![GIF.gif](http://upload-images.jianshu.io/upload_images/2803682-a275b5a23e0357a8.gif?imageMogr2/auto-orient/strip)

点击Button调用代码
```
 private void show() {
        Dialog dialog = new Dialog(this);
        //去掉标题线
        dialog.requestWindowFeature(android.view.Window.FEATURE_NO_TITLE);
        dialog.setContentView(R.layout.dialog);
        //背景透明
        dialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent);
        dialog.show();

        Window window = dialog.getWindow();
        WindowManager.LayoutParams lp = window.getAttributes();
        lp.gravity = Gravity.CENTER; // 居中位置
        lp.width = WindowManager.LayoutParams.MATCH_PARENT;
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        window.setAttributes(lp);
        window.setWindowAnimations(R.style.mystyle);  //添加动画
    }
```

Dialog的自定义布局
```
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"
    android:orientation="vertical">

    <LinearLayout
        android:layout_width="300dp"
        android:layout_height="wrap_content"
        android:background="@drawable/dialog"
        android:gravity="center"
        android:orientation="vertical"
        android:padding="10dp">

        <EditText
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="用户名" />

        <EditText
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="密码" />

        <Button
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="确定" />
    </LinearLayout>
</LinearLayout>
```

Dialog的自定义布局Share样式，drawable里面新建
```
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <!--圆角-->
    <corners android:radius="30dp" />

    <!--填充色-->
    <solid android:color="#ffffff" />
</shape>
```

弹出动画样式，在styles里面添加
```
 <!--弹窗动画-->
    <style name="mystyle" parent="android:Animation">
        <!--//进入时的动画-->
        <item name="@android:windowEnterAnimation">@anim/dialog_enter</item>
        <!--//退出时的动画-->
        <item name="@android:windowExitAnimation">@anim/dialog_exit</item>
    </style>
```

弹出动画,新建anim文件目录，一个进入 一个退出的，
```
<set xmlns:android="http://schemas.android.com/apk/res/android">
    <translate
        android:duration="500"
        android:fromYDelta="100%"
        android:toYDelta="0" />
</set>
```

退出的
```
<set xmlns:android="http://schemas.android.com/apk/res/android">
    <translate
        android:duration="500"
        android:fromYDelta="0"
        android:toYDelta="100%" />
</set>
```

参考大神的文章 http://www.jianshu.com/p/9e3cac6aca17
主要是自己备份下。。。顺便能帮到人更好哈哈
