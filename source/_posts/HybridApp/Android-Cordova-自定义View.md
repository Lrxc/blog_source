---
title: Android-Cordova-自定义View
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---

<meta name="referrer" content="no-referrer" />


一.  正常使用继承CordovaActivity 
二.  重写 loadUrl("http://www.jianshu.com/") 
但是页面是全屏 且不能自定义 比如添加ToolBar

那么有没有办法自定义VIew呢，答案肯定是有的
一. 继承CordovaActivity 设置setContentView
```
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        loadUrl("http://www.jianshu.com");
    }
```

二. 新建布局SystemWebView
```
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <android.support.v7.widget.Toolbar
        android:id="@+id/toolbar"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@color/colorPrimary" />

    <org.apache.cordova.engine.SystemWebView
        android:id="@+id/tutorialView"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
</LinearLayout>
```

三.  重写makeWebView 
```
    @Override
    protected CordovaWebView makeWebView() {
        //自定义webview
        SystemWebView tutorialView = (SystemWebView) findViewById(R.id.systemWebview);
        return new CordovaWebViewImpl(new SystemWebViewEngine(tutorialView));
    }
```

四. 重写createViews    super方法必须注释掉
```
    @Override
    protected void createViews() {
        //super.createViews();必须注释
    }
```

其实就是二、三方法 很简单，可以添加ToolBar的。。。
