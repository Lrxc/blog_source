---
title: Android-Studio-Cordova-自定义插件之Toast(二)
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---


#####说明：推荐Cordova原生调用方式，优点是代码和逻辑简单，容易理解http://www.jianshu.com/p/526d6872e271 本文是*标准插件版*


######一  配置Android Studio Cordova项目，不会的参考这个 http://www.jianshu.com/p/968747f4dcf9

######二  自定义插件
**1.新建Toast Plugin 插件.如图目录 新建类文件 Toast**

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
        if ("showToast".equals(action)) {
            showToast(args.getString(0), args.getInt(1));
        }
        return true;
    }

    private void showToast(String text, int type) {
        android.widget.Toast.makeText(cordova.getActivity(), text, type).show();
    }
}
```

**2.配置config 文件**
```
 <feature name="CustomToast">
        <param name="android-package" value="org.apache.cordova.toast.Toast" />
  </feature>
```

**3.编写h5页面调用js代码**
```
function showToast(){
      navigator.toast.callToast("测试Toast成功",0);
 }
```
**4.编写插件js文件,如图目录新建toast.js**

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2803682-83e051a8552baaa5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

内容如下
```
// define中填写 cordova_plugins 中 填写的相应的 id
cordova.define("cordova-plugin-toast.toast", function(require, exports, module) {
var exec = require('cordova/exec');
module.exports ={
callToast:function (content,type) {
     exec(null, null, "CustomToast", "showToast", [content,type]);
        }
    };
});
```
**5.配置清单 cordova_plugins.js**

module.exports添加(**若不是最后一个,不要忘了语文逗号**)
```
{
     "id": "cordova-plugin-toast.toast",//cordova.define的id
     "file": "plugins/cordova-plugin-toast/www/toast.js",//js文件
     "pluginId": "cordova-plugin-toast",
     "clobbers": [
         "navigator.toast"//js调用时方法名
     ]
 },
```
module.exports.metadata中添加(**若不是最后一个,不要忘了语文逗号**)
```
    "cordova-plugin-toast":"1.0.0",
```

#####说明1：上面代码中的  **CustomToast** **showToast**  **callToast** 都是有对应的，改名记得对应地方也要改

#####说明2：创建顺序不必纠结，这个是为了对比原生(http://www.jianshu.com/p/526d6872e271)的方式
