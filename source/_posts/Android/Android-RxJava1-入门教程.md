---
title: Android-RxJava1-入门教程
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


添加依赖（注意是rxjava1 不是rxjava2 ！！）
```
compile 'io.reactivex:rxjava:1.3.0'
compile 'io.reactivex:rxandroid:1.2.1'
```

一。  基本使用
1.  首先新建被观察者
```
//被观察者
        Observable<String> observable = Observable.create(new Observable.OnSubscribe<String>() {
            @Override
            public void call(Subscriber<? super String> subscriber) {
                subscriber.onNext("this is a message 1");//发送第一条信息
                subscriber.onNext("this is a message 2");//发送第二条信息
                subscriber.onCompleted();//发送完成
            }
        });
```

2.   订阅者
```
 Subscriber<String> subscriber = new Subscriber<String>() {
            @Override
            public void onCompleted() {
                //全部接受完回调
                Log.i(TAG, "onCompleted: ");
            }

            @Override
            public void onError(Throwable e) {
                //错误的回调
                Log.i(TAG, "onError: " + e.getMessage());
            }

            @Override
            public void onNext(String o) {
                //接受单条数据
                Log.i(TAG, "onNext: " + o);
                Toast.makeText(MainActivity.this, o, Toast.LENGTH_SHORT).show();
            }
        };
```
3.订阅关系
```
//订阅关系
        observable.subscribe(subscriber);//添加订阅者
```
运行下(上面全部放到activity oncreate方法中就行了)，这就是最基本的使用了，是不是很简单呢


二：耗时操作，RxJava本来就是处理异步的 而且特别简单

添加耗时操作，上面 被观察者代码中 增加就行
```
try {
    Thread.sleep(9000);//模拟耗时操作，网络请求
} catch (InterruptedException e) {
    e.printStackTrace();
}
subscriber.onNext("this is a message 1");
subscriber.onNext("this is a message 2");
subscriber.onCompleted();
```

现在直接运行肯定会ANR的。。
很简单 ，只需要修改下订阅关系：
```
observable.subscribeOn(Schedulers.io())//订阅者运行在子线程
        .observeOn(AndroidSchedulers.mainThread())//Toast回到主线程
        .subscribe(subscriber);
```

怎么样？是不是不需要Handler发过来发过去了。。。


这是最原始的用法，下面开始精简用法
三。  精简使用


针对上面第一个的简单实现
```
String[] values = {"this is a message 1", "this is a message 2"};//定义一个数组
Observable.from(values)
         .subscribe(new Subscriber<String>() {
             @Override
             public void onCompleted() {}

             @Override
             public void onError(Throwable e) {}

             @Override
             public void onNext(String s) {
                 Toast.makeText(MainActivity.this, s, Toast.LENGTH_SHORT).show();
             }
          });
```

当然，还可以更简单
```
 String[] values = {"this is a message 1", "this is a message 2", "this is a message 3"};
 Observable.from(values)
                .subscribe(new Action1<String>() {
                    @Override
                    public void call(String s) {
                        Toast.makeText(MainActivity.this, s, Toast.LENGTH_SHORT).show();
                    }
                });
```
怎么？还不够简洁，再来！
```
String[] values = {"this is a message 1", "this is a message 2", "this is a message 3"};
Observable.from(values)
        .subscribe(s -> Toast.makeText(MainActivity.this, s, Toast.LENGTH_SHORT).show());//lambda表达式形式
```
这已经是最简单了。。。
关于lambda语法，自己看下吧 特备简单，就是一些缩写而已，
AS需要配置 ：https://github.com/evant/gradle-retrolambda  



最后附一个  过滤非偶数，并乘以2，转换成String类型，输出的例子(lambda语法形式)
```
Integer[] values = {1, 3, 4, 7, 8};
Observable.from(values)
        .filter(integer -> integer % 2 == 0)//过滤非偶数
        .scan((integer, integer2) -> integer2 * 2)//函数*2
        .map(value -> value + "")//转换string格式
        .subscribeOn(Schedulers.io())//调度器分配线程
        .observeOn(AndroidSchedulers.mainThread())//回到主线程
        .subscribe(s -> Log.i(TAG, "test:--- " + s));//打印日志
```

................................END...............................
