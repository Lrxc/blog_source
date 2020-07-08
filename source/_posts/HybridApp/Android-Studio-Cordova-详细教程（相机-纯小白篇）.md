---
title: Android-Studio-Cordova-详细教程（相机-纯小白篇）
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---

<meta name="referrer" content="no-referrer" />


一。  首先安装Cordova
1. 打开Cordova官网 http://cordova.axuer.com 点击入门
2. 先安装Node，点击步骤1中的Node.js,下载安装 
3. 打开cmd 依次输入上图命令 创建第一个cordova demo（第一个命令安装cordova是从服务器下载 跟网速有关，耐心等待）
4. 创建Cordova项目


二。  添加Camera插件
上面步骤后cmd不要闭关 继续输入 添加相机插件
```
cordova plugin add cordova-plugin-camera
```


三。  生成Android Studio 可用的Cordova jar包
1. Android Cordova 官方github：https://github.com/apache/cordova-android 直接整个项目Download下来就行了
2. 下载ant 官网：http://ant.apache.org/  下载解压  配置path环境
进入解压Cordova目录的/framework，然后执行指令ant jar(目录下需要新建local.properties文件 指定sdk路径 可以从其他的Android Studio项目中直接复制一个过来),生成cordova-X.X.X-dev.jar


四。  新建Android Studio Cordova 项目
1. 新建正常Android studio 项目 复制cordova-X.X.X-dev.jar 到libs下    Add As Library...
2. MainActiviaty页面
```
 public class CordovaViewTestActivity extends CordovaActivity {
     @Override
     public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        loadUrl(launchUrl);//加载h5页面
     }
```
3. 新建assets目录，并把Cordova项目中assets目录下的www文件复制过去
4. 把Cordova项目下src下的org复制到src/mian/java 下面
5. 把Cordova项目下res下xml复制到 res下
6. 打开AndroidManifest  相机权限
```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
并在application 标签下 加入调用相机的代码
```
  </application>
  ...
     <!--js调用原生相机-->
    <provider
            android:name="android.support.v4.content.FileProvider"
            android:authorities="${applicationId}.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths" />
        </provider>
    </application>
```


五。  配置js文件
1 index.html文件中添加一个按钮 设置一个点击方法
```
<button onclick="takephoto()">takephoto</button>
```
js中写对应方法
```


//只有在deviceready事件触发以后才可以监听拍照事件
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
    console.log(navigator.camera);
}

//拍照方法(对应button方法名字)
function takephoto(){
     navigator.camera.getPicture(onSuccess, onFail, { quality: 50,
                destinationType: Camera.DestinationType.DATA_URL
            });
}

//成功回调
function onSuccess(imageData) {
    var image = document.getElementById('myImage');
    image.src = "data:image/jpeg;base64," + imageData;
}

//失败回调
function onFail(message) {
    alert('Failed because: ' + message);
}
```


运行试试效果吧
附个人demo： https://git.coding.net/Lrxc/LrxcCordova.git
