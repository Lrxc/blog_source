---
title: Android-Studio-Cordova-自定义插件之Toast(一)
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---

<meta name="referrer" content="no-referrer" />


#####说明： 这种方式是Cordova原生调用方式，优点是代码和逻辑简单，容易理解。标准版插件格式http://www.jianshu.com/p/2f00e1864fbd

**一  配置Android Studio Cordova项目，不会的参考这个 http://www.jianshu.com/p/968747f4dcf9**


**二  自定义插件**

**1  新建Toast Plugin 插件**
    如图目录 新建文件 Toast

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-54e36bc54bf2ea8a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

代码如下
 ```
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

public class Toast extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("Java_Toast".equals(action)) {
            showToast(args.getString(0), args.getInt(1));
        }
        return true;
    }

    private void showToast(String text, int type) {
        android.widget.Toast.makeText(cordova.getActivity(), text, type).show();
    }
}
```

**2  配置config 文件**
```
 <feature name="Config_Toast">
        <param name="android-package" value="org.apache.cordova.toast.Toast" />
  </feature>
```

**3  编写h5页面调用js代码**
```
function showToast(){
       Cordova.exec(pluginSuccess, pluginFailed, "Config_Toast", "Java_Toast", ["测试Toast成功",0]);
 }
//成功回调
var pluginSuccess = function(message) {
     alert("success>>" + message);
 }
//失败回调
 var pluginFailed = function(message) {
     alert("failed>>" + message);
 }
```

#####说明1：上面代码中的  **Config_Toast**  **Java_Toast** 都是有对应的，改名记得对应地方也要改
