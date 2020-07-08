---
title: Android-微信分享
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


一 .  获取开发者APP_ID
打开微信开发者平台 创建应用 获取APP_ID，一般两三天审核通过
```
https://open.weixin.qq.com
```

二.   集成微信SDK

1.  添加依赖  
```
compile 'com.tencent.mm.opensdk:wechat-sdk-android-without-mta:+'
```

2.  AndroidManifest.xml 设置
```
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

3.调用的页面 例如MainActivity中
```
public class MainActivity extends AppCompatActivity {
    private IWXAPI api;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        api = WXAPIFactory.createWXAPI(this, WXEntryActivity.APP_ID, true);
    }

    //分享文本
    public void WeChatShare1(View view) {
        String text = "测试数据";
        WXTextObject textObj = new WXTextObject();
        textObj.text = text;

        initSend(textObj);
    }

    //分享图片
    public void WeChatShare2(View view) {
        Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        WXImageObject object = new WXImageObject(bitmap);

        initSend(object);
    }

    //分享链接
    public void WeChatShare(View view) {
        WXWebpageObject webpage = new WXWebpageObject();
        webpage.webpageUrl = "http://www.baidu.com";

        initSend(webpage);
    }

    private void initSend(WXMediaMessage.IMediaObject webpage) {
        WXMediaMessage msg = new WXMediaMessage();
        msg.title = "测试标题";
        msg.description = "测试说明...";
        msg.mediaObject = webpage;

        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = buildTransaction("webpage");
        req.message = msg;
        req.scene = SendMessageToWX.Req.WXSceneSession;    //设置发送到朋友
//        req.scene = SendMessageToWX.Req.WXSceneTimeline;    //设置发送到朋友圈

        api.sendReq(req);
    }

    private String buildTransaction(final String type) {
        return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
    }
}

```

三.  设置分享

1.  包名相应目录下新建包名 wxapi，在里面新建类 WXEntryActivity 继承自AppCompatActivity即可(名字必须是这两个)
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-bffd7a253af1c43a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
 public class WXEntryActivity extends AppCompatActivity implements IWXAPIEventHandler {
    //申请的appid
    public static final String APP_ID = "申请的ID";
    //第三方app和微信通信的接口
    private IWXAPI api;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        regToWx();
    }

    public void regToWx() {
        //获取IWXAPI的实例
        api = WXAPIFactory.createWXAPI(this, APP_ID, true);
        //将应用appid注册到微信
        api.registerApp(APP_ID);
        //回调监听
        api.handleIntent(getIntent(), this);
    }

    @Override
    public void onReq(BaseReq baseReq) {
    }

    @Override
    public void onResp(BaseResp resp) {
        String result;
        switch (resp.errCode) {
            case BaseResp.ErrCode.ERR_OK:
                result = "分享成功";
                break;
            case BaseResp.ErrCode.ERR_USER_CANCEL:
                result = "取消分享";
                break;
            case BaseResp.ErrCode.ERR_AUTH_DENIED:
                result = "分享被拒绝";
                break;
            default:
                result = "发送失败";
                break;
        }
        Toast.makeText(this, result, Toast.LENGTH_SHORT).show();
        finish();
    }
}
```

2.  AndroidManifest.xml 添加，用于接受分享后的回掉，否则上一步中onReq()，onResp()无效
```
<!--微信回调-->
<application>
...
   <activity
       android:name=".wxapi.WXEntryActivity"
       android:exported="true" />
</application>
```


最后说明：必须要用真机测试 虚拟机会有各种莫名其妙的问题！
最后说明：必须要用真机测试 虚拟机会有各种莫名其妙的问题！
最后说明：必须要用真机测试 虚拟机会有各种莫名其妙的问题！
