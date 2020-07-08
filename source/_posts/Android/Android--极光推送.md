---
title: Android--极光推送
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


一. 注册平台信息
官网：https://www.jiguang.cn/
1. 新建应用，名字随意
2. 选择推送设置
3. 填写项目包名，不可更改，一定不能错

二. 项目集成
官方文档，很详细了https://docs.jiguang.cn/jpush/client/Android/android_guide/
使用jcenter 自动集成步骤，简单，清晰
1.  app build.gradle中
```
android {
    ......
    defaultConfig {
        applicationId "com.xxx.xxx" //JPush上注册的包名.
        ......

        ndk {
            //选择要添加的对应cpu类型的.so库。
            abiFilters 'armeabi', 'armeabi-v7a', 'arm64-v8a'
            // 还可以添加 'x86', 'x86_64', 'mips', 'mips64'
        }

        manifestPlaceholders = [
            JPUSH_PKGNAME : applicationId,
            JPUSH_APPKEY : "你的appkey", //JPush上注册的包名对应的appkey.
            JPUSH_CHANNEL : "developer-default", //暂时填写默认值即可.
        ]
        ......
    }
    ......
}

dependencies {
    ......

    compile 'cn.jiguang.sdk:jpush:3.0.9'  // 此处以JPush 3.0.9 版本为例。
    compile 'cn.jiguang.sdk:jcore:1.1.7'  // 此处以JCore 1.1.7 版本为例。
    ......
}
```
2. 新建Application 类
```
public class ExampleApplication extends Application {
@Override
    public void onCreate() {
        super.onCreate();
        JPushInterface.setDebugMode(true);
        //必须初始化
        JPushInterface.init(this);
    }
}
```
3. mainfest 记得配置Application

三.  开始推送
![image.png](http://upload-images.jianshu.io/upload_images/2803682-182a4437a0c0f182.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击发送 ，就这么简单

四.  接受通知内容触发活动
官方高级文档说明：https://docs.jiguang.cn/jpush/client/Android/android_senior/
1. 自定义BroadcastRecevice
```
public class MyReceiver extends BroadcastReceiver {
    private static final String TAG = "MyReceiver";

    private NotificationManager nm;

    @Override
    public void onReceive(Context context, Intent intent) {
        if (null == nm) {
            nm = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        }

        Bundle bundle = intent.getExtras();
        Log.d(TAG, "onReceive - " + intent.getAction() + ", extras: ");

        if (JPushInterface.ACTION_REGISTRATION_ID.equals(intent.getAction())) {
            Log.d(TAG, "JPush用户注册成功");

        } else if (JPushInterface.ACTION_MESSAGE_RECEIVED.equals(intent.getAction())) {
            Log.d(TAG, "接受到推送下来的自定义消息");

        } else if (JPushInterface.ACTION_NOTIFICATION_RECEIVED.equals(intent.getAction())) {
            Log.d(TAG, "接受到推送下来的通知");

            receivingNotification(context, bundle);

        } else if (JPushInterface.ACTION_NOTIFICATION_OPENED.equals(intent.getAction())) {
            Log.d(TAG, "用户点击打开了通知");

            openNotification(context, bundle);

        } else {
            Log.d(TAG, "Unhandled intent - " + intent.getAction());
        }
    }

    private void receivingNotification(Context context, Bundle bundle) {
        String title = bundle.getString(JPushInterface.EXTRA_NOTIFICATION_TITLE);
        Log.d(TAG, " title : " + title);
        String message = bundle.getString(JPushInterface.EXTRA_ALERT);
        Log.d(TAG, "message : " + message);
        String extras = bundle.getString(JPushInterface.EXTRA_EXTRA);
        Log.d(TAG, "extras : " + extras);
    }

    private void openNotification(Context context, Bundle bundle) {
    }
}
```
2. mainfest 记得添加广播
```
<receiver
    android:name=".MyReceiver"
    android:enabled="true"
    android:exported="false">
    <intent-filter>
        <action android:name="cn.jpush.android.intent.REGISTRATION" /> <!--Required  用户注册SDK的intent-->
        <action android:name="cn.jpush.android.intent.MESSAGE_RECEIVED" /> <!--Required  用户接收SDK消息的intent-->
        <action android:name="cn.jpush.android.intent.NOTIFICATION_RECEIVED" /> <!--Required  用户接收SDK通知栏信息的intent-->
        <action android:name="cn.jpush.android.intent.NOTIFICATION_OPENED" /> <!--Required  用户打开自定义通知栏的intent-->
        <action android:name="cn.jpush.android.intent.ACTION_RICHPUSH_CALLBACK" /> <!--Optional 用户接受Rich Push Javascript 回调函数的intent-->
        <action android:name="cn.jpush.android.intent.CONNECTION" /><!-- 接收网络变化 连接/断开 since 1.6.3 -->
        <category android:name="你的项目包名" />
    </intent-filter>
</receiver>
```
3 .再次推送信息，并查看日志，对应的方法里面处理即可


