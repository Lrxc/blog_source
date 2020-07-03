---
title: Java-泛型
date: 2019-07-01 16:01:33
categories: Java
tags: java
---


一. 常用通配符
**都是通配符，没有区别，只是为了提高阅读性，使用A-Z中任意一个字母都是可以的**
```
常用的 T，E，K，V，？
？ 表示不确定的 java 类型
T (type) 表示具体的一个java类型
K V (key value) 分别代表java键值中的Key Value
E (element) 代表Element
```
二. 泛型方法
```
public class FanChild<T> {

    private T obj;

    /**
     * 泛型烦方法
     */
    public void add(T e) {
        this.obj = e;
    }

    public T get() {
        return obj;
    }
}
```
测试
```
    public static void main(String[] args) {
        FanChild<String> fan = new FanChild<String>();
        fan.add("123");
        String s = fan.get();
        System.out.println(s);
    }
```


三. 泛型静态方法
```
public class Fan {

    /**
     * 泛型静态方法
     */
    public static <T> T add(T t) {
        return t;
    }
}
```
测试
```
    public static void main(String[] args) {
        String add = Fan.add("123");
        System.out.println(add);
    }
```
