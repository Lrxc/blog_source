---
title: Weex-Android-原生交互
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---


不会新建项目的小伙伴点这儿http://www.jianshu.com/p/94267514204f

一.  配置Android项目
1. 自定义Module
官方文档：http://weex.apache.org/cn/references/advanced/extend-to-android.html
```
public class MyModule extends WXModule {
    @WXModuleAnno(runOnUIThread = true)
    public void printLog(String msg) {
        Toast.makeText(mWXSDKInstance.getContext(), msg, Toast.LENGTH_SHORT).show();
    }

    @WXModuleAnno(runOnUIThread = false)
    public void nativeCallBack(JSCallback callback) {
        //回调信息
        callback.invoke("I am callback message");
    }
}
```

2.  application onCreate中注册
```
//初始化Weex
InitConfig config = new InitConfig.Builder().setImgAdapter(null).build();
WXSDKEngine.initialize(this, config);
try {
    //通信方法 myModule是weex调用原生的方法名
    WXSDKEngine.registerModule("myModule", MyModule.class);
} catch (WXException e) {
    e.printStackTrace();
}
```

二. 配置Weex项目
1.  编写index.vue 内容
```
<template>
    <div>
        <text @click="onClick">Android Toast</text>
        <text @click="onCallBack">CallBack</text>
    </div>
</template>
<script>
    module.exports = {
        methods: {
            onClick: function () {
                weex.requireModule('myModule').printLog("我是一个测试!");
            },
            onCallBack: function () {
                let func = weex.requireModule('myModule');
                func.nativeCallBack(function (event) {
                    //回调后处理
                    func.printLog('回调: ' + event);
                });
            }
        }
    }
</script>
```
2. 编译为js文件
FirstApp 根目录执行命令，成功后生成dist目录，进去复制index.js到Android Studio项目assets中
```
npm run build
```
三. 运行Android Studio 看效果吧
![GIF.gif](http://upload-images.jianshu.io/upload_images/2803682-315a8c18736be596.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
