---
title: Weex-Android-Studio
date: 2020-07-01 16:01:33
categories: Hybrid
tags: hybrid
---

<meta name="referrer" content="no-referrer" />


一. 搭建Weex开发环境  官网http://weex.apache.org/cn/
1. node
官网:https://nodejs.org/en/
2. 安装weex环境
```
npm install -g weex-toolkit
weex -v //查看当前weex版本
```
能显示版本说明正常

二 新建Weex项目
1. 新建一个本地目录，目录下执行
```
 weex create FirstApp  //FirstApp  项目名
```
2. 安装项目依赖
```
npm install //一定要执行 否则后续编译失败
```
3. 打开FristApp ，找到start.bat并运行，浏览器显示如下，成功
![image.png](http://upload-images.jianshu.io/upload_images/2803682-79e509ac7aa8597f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 运行到Android设备(知道这种方式就好 有坑, 跳过就行)
```
weex platform add android //添加Android平台
weex run android //运行到Android 设备
```
说明：垃圾Weex官方坑，自己的项目地址都不能用。因为下面的地址打不开(翻墙也不行),Build就死了。。
```
//这是官方的项目maven地址，既然打不开还用，尼玛。。。
maven { url "http://mvnrepo.alibaba-inc.com/mvn/repository" }
maven { url "http://mvnrepo.alibaba-inc.com/mvn/snapshots" }
```


三. 配置Android Studio 新建项目
官方文档：http://weex.apache.org/cn/guide/integrate-to-your-app.html
1. app build.gradle中，这三个是必须要有的
```
    compile 'com.android.support:recyclerview-v7:26.1.0'
    compile 'com.alibaba:fastjson:1.1.46.android'
    compile 'com.taobao.android:weex_sdk:0.10.0@aar' //核心依赖  
```
一定要更新最新版本，否则可能加载JS失败，垃圾Weex官方坑
![image.png](http://upload-images.jianshu.io/upload_images/2803682-dbd8d44721784346.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 新建application onCreate中初始化
```
   //不想新建ImageAdapter 直接用null也可以
   InitConfig config=new InitConfig.Builder().setImgAdapter(null).build();
   //InitConfig config=new InitConfig.Builder().setImgAdapter(new ImageAdapter()).build();
    WXSDKEngine.initialize(this,config);
```
记得mainfest配置,记得mainfest配置,记得mainfest配置
3. MainActivity 参考官方 全部复制即可
```
//因为核心依赖库是最新的，所以和官方有区别
 mWXSDKInstance.render("WXSample", WXFileUtils.loadAsset("index.js", this), null, null, -1, -1, WXRenderStrategy.APPEND_ASYNC);//index.js 名字对用assets中的 
```
注意：默认是不会重写setContentView()方法的
```
    @Override
    public void onViewCreated(WXSDKInstance instance, View view) {
        setContentView(view);//一定重写 否则js页面不会加载
    }
```
4. 添加weex编写的文件
FirstApp 根目录执行命令
```
npm run build
```
附加：编译就是将.vue编译成js文件，下面两种方式也可以
```
weex index.vue -o .  //后面是个英文 .  意思是说存放到当前目录
weex compile index.vue js 
```
成功后生成dist目录，进去复制index.js到Android Studio项目assets中
5. Android Studio 运行看效果


