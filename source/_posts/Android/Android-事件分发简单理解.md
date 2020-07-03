---
title: Android-事件分发简单理解
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


简单理解：Activity、ViewGroup(LinearLayout,RelativeLayout...)，View（Button,TextView...）

Activity :老板
ViewGroup:组长
View:程序员小王

Activity如下
```
public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.touchView).setOnClickListener(this);
        findViewById(R.id.btn).setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.touchView:
                Log.i("ddms", "onClick: 点击了空白");
                break;
            case R.id.btn:
                Log.i("ddms", "onClick: 点击了按钮");
                break;
        }
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        Log.i("ddms", "dispatchTouchEvent:老板: 我要增加功能");
        return super.dispatchTouchEvent(ev);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        Log.i("ddms", "onTouchEvent:老板: 太复杂,简化下");
        return super.onTouchEvent(event);
    }
}
```

XML 如下
```
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.example.bxlt.myapplication.TouchViewGroup
        android:id="@+id/touchView"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <com.example.bxlt.myapplication.TouchButton
            android:id="@+id/btn"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="btn" />
    </com.example.bxlt.myapplication.TouchViewGroup>
</android.support.constraint.ConstraintLayout>
```

ViewGroup如下
```
public class TouchViewGroup extends RelativeLayout {

    public TouchViewGroup(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        Log.i("ddms", "dispatchTouchEvent:组长: 老大要加功能");
        return super.dispatchTouchEvent(ev);
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {
        Log.i("ddms", "onInterceptTouchEvent: 组长: 先问问小王");
        return super.onInterceptTouchEvent(ev);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        boolean b = super.onTouchEvent(event);
        Log.i("ddms", "onTouchEvent:组长: 小王说搞不了,自己搞？" + b);
        return b;
    }
}
```

VIew如下
```
public class TouchButton extends Button {

    public TouchButton(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        Log.i("ddms", "dispatchTouchEvent:小王: 要加功能？");
        return super.dispatchTouchEvent(event);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        boolean b = super.onTouchEvent(event);
        Log.i("ddms", "onTouchEvent:小王: 能搞？" + b);
        return b;
    }
}
```

点击按钮(为什么两遍Log?因为down 和up 各一遍)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e1ca72b96ca6b7e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


改成小王不干，onTouchEvent返回false
![image.png](https://upload-images.jianshu.io/upload_images/2803682-50b5443e15316a53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-f5b35541d08ac005.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
说明：View的onTouchEvent返回false，ViewGroup的onTouchEvent 开始执行。另外最后的log是点击了空白，说明btn的点击事件已失效

改成组长也不干，onTouchEvent返回false
![image.png](https://upload-images.jianshu.io/upload_images/2803682-053deb38ddf102ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-790e0a962b6705a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
说明:老板下次下发任务，直接无效应。最后的log没有了，说明ViewGroup点击事件也失效了

大神文章：http://wuxiaolong.me/2015/12/19/MotionEvent/








