---
title: Android RelativeLayout-布局重叠下层的控件会响应
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


偶然间遇到的一个问题，自定义view上传图片进度条，发现下层的控件还可以选。。。后来改成自定义dialog了
抽空找了找资料 http://wenda.so.com/q/1447517100721093  发现好像没什么卵用。。。
下面来干货：

方法：对当前LinearLayout(id : layout)增加监听就行了
```
 findViewById(R.id.layout).setOnClickListener(null);
```

布局如下
```
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="com.bxlt.demo01.MainActivity">

    <ImageView
        android:id="@+id/img"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:src="@mipmap/ic_launcher" />

    <LinearLayout
        android:id="@+id/layout"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:gravity="center"
        android:orientation="vertical">

        <Button
            android:id="@+id/btn"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />
    </LinearLayout>
</RelativeLayout>
```

Activity：
```
  findViewById(R.id.img).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.i(TAG, "onClick: img");
            }
        });
  findViewById(R.id.btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Log.i(TAG, "onClick: btn");
            }
        });
```

此刻点击图片或者Button都是可以响应的，怎么才能只响应上层的Button，而不响应下层的图片呢？
加上这句：
```
findViewById(R.id.layout).setOnClickListener(null);
```
完美解决
