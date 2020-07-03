---
title: Xposed-插件开发记录
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


一  SharedPreferences数据保存
putStringSet：一个key对应多个字段使用
```
 values = preferences.getStringSet(CommonName.PACKAGE_NAME, values);
//bug说明： Xposed插件杀掉后，再次获取数据时，发现只能获取到一个数据
 edit.clear();
```
二 方法说明
```
//方法使用
XposedHelpers.findAndHookMethod()
//成员变量
XposedHelpers.setObjectField()
//静态成员变量（两种都可以）
XposedHelpers.setObjectField()
XposedHelpers.setStaticObjectField()
```
三 代码
```
//hook成员变量
XposedHelpers.findAndHookMethod("com.lrxc.test.MainActivity", lpparam.classLoader, "getString", String.class
        , new XC_MethodHook() {
            @Override
            protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
                super.beforeHookedMethod(param);
                //核心方法
                XposedHelpers.setStaticObjectField(param.thisObject.getClass(), "li", "智障");
            }
        });
```
```
//hook静态成员变量，不需要借助findAndHookMethod，直接反射
Class<?> aClass = lpparam.classLoader.loadClass("android.os.Build");
//修改手机厂商
XposedHelpers.setStaticObjectField(aClass, "BRAND", vendor);
```
