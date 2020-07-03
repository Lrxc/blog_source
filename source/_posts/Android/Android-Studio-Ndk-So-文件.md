---
title: Android-Studio-Ndk-So-文件
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


一 下载NKD,并解压
官网：https://developer.android.com/index.html
二 新建项目
1 新建Android Studio项目
2 项目配置NDK路径
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e9111656bbe2cb3f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 gradle.properties 增加
```
//使用NDK
android.useDeprecatedNdk=true
```
3 项目的build.gradle defaultConfig增加
```
 ndk {
            moduleName "native-jni"        // 生成的so动态库名称
            abiFilters "armeabi", "armeabi-v7a", "x86" // 输出指定三种abi体系结构下的so库
        }
```
三 写相关代码
1 新建jni目录
2 新建jni调用类
```
public class JNIUtils {
    // 加载native-jni
    static {
        System.loadLibrary("native-jni");
    }
    //java调C中的方法都需要用native声明且方法名必须和c的方法名一样
    public native String stringFromJNI();
}
```
3 打开底部Terminal  进入到 ../src/main/java路径下 生成  .h文件
```
javah -d jni com.example.bxlt.myapplication.JNIUtils
```
成功后生成对应文件
![image.png](https://upload-images.jianshu.io/upload_images/2803682-3137b5be0666cd10.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. jni路径下新建c文件，保持名字一致
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6748aaa00181841f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
内容如下
```
#include "com_example_bxlt_myapplication_JNIUtils.h"

JNIEXPORT jstring JNICALL Java_com_example_bxlt_myapplication_JNIUtils_stringFromJNI
  (JNIEnv *env, jobject obj){
    return (*env)->NewStringUTF(env,"这里是C++代码");
  }
```
C的内容说明：这三个地方名字一致
![image.png](https://upload-images.jianshu.io/upload_images/2803682-90f3902034e47583.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5 Android 调用
```
        TextView tv = findViewById(R.id.tv);
        tv.setText(new JNIUtils().stringFromJNI());
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-f2c76e7215324dbd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6 SO文件
![image.png](https://upload-images.jianshu.io/upload_images/2803682-620f7e25425fa36c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)






