---
title: Android--自定义相机(前后切换、闪光灯、对焦、镜头缩放)
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


最近项目中使用相机功能，需要自定义，整理下，给需要的朋友
实现的功能：前后镜头切换、闪光灯模式(三种)、对焦、镜头手势缩放、本地保存、弹窗预览
实现逻辑：自定义View继承自SurfaceView，Activity 布局中引入，在Activity中进行各种操作 拍照，对焦等等

镜头切换方法：
```
 //切换摄像头
    private int cameraPosition = 1; //当前选用的摄像头，1后置 0前置

    public void switchFrontCamera() {
        int cameraCount = Camera.getNumberOfCameras();//得到摄像头的个数
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();

        for (int i = 0; i < cameraCount; i++) {
            Camera.getCameraInfo(i, cameraInfo);//得到每一个摄像头的信息
            if (cameraPosition == 1) {
                //现在是后置，变更为前置
                if (cameraInfo.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {//代表摄像头的方位，CAMERA_FACING_FRONT前置      CAMERA_FACING_BACK后置
                    //重新打开
                    reStartCamera(i);
                    cameraPosition = 0;
                    break;
                }
            } else {
                //现在是前置， 变更为后置
                if (cameraInfo.facing == Camera.CameraInfo.CAMERA_FACING_BACK) {//代表摄像头的方位，CAMERA_FACING_FRONT前置      CAMERA_FACING_BACK后置
                    reStartCamera(i);
                    cameraPosition = 1;
                    break;
                }
            }
        }
    }

    //重新打开预览
    public void reStartCamera(int i) {
        if (camera != null) {
            camera.stopPreview();//停掉原来摄像头的预览
            camera.release();//释放资源
            camera = null;//取消原来摄像头
        }
        try {
            camera = Camera.open(i);//打开当前选中的摄像头
            camera.setPreviewDisplay(holder);//通过surfaceview显示取景画面
//            camera.setDisplayOrientation(90);// 屏幕方向
            camera.startPreview();//开始预览
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
```

闪光灯模式
```
camePreview.setIsOpenFlashMode(Camera.Parameters.FLASH_MODE_AUTO);//自动模式
camePreview.setIsOpenFlashMode(Camera.Parameters.FLASH_MODE_ON);//总是开启
camePreview.setIsOpenFlashMode(Camera.Parameters.FLASH_MODE_OFF);//总是关闭

    //设置开启闪光灯(重新预览)
    public void setIsOpenFlashMode(String mIsOpenFlashMode) {
        Camera.Parameters mParameters = camera.getParameters();
        //设置闪光灯模式
        mParameters.setFlashMode(mIsOpenFlashMode);
        camera.setParameters(mParameters);
    }
```

镜头对焦
```
    // 手动对焦
    public void autoFocus() {
        camera.autoFocus(null);//自动对焦 不需要回调
    }

    //自动连续对焦
        Camera.Parameters parameters = camera.getParameters();
        if (parameters.getSupportedFocusModes().contains(android.hardware.Camera.Parameters.FOCUS_MODE_CONTINUOUS_PICTURE)) {
            parameters.setFocusMode(android.hardware.Camera.Parameters.FOCUS_MODE_CONTINUOUS_PICTURE);// 连续对焦模式
        }
        camera.setParameters(parameters);

```

手势缩放
```
    //Activity中初始化
    ScaleGestureDetector gestureDetector = new ScaleGestureDetector(this, new ScaleGestureListener());

    //重写onTouchEvent方法 获取手势
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        //识别手势
        gestureDetector.onTouchEvent(event);
        return super.onTouchEvent(event);
    }

    //操作类
    class ScaleGestureListener implements ScaleGestureDetector.OnScaleGestureListener {
        float mScaleFactor;

        @Override
        public boolean onScale(ScaleGestureDetector detector) {
            if (detector.getCurrentSpan() > mScaleFactor) {
                camePreview.zoomOut();
            } else {
                camePreview.zoomIn();
            }
            mScaleFactor = detector.getCurrentSpan();
            return false;
        }

        @Override
        public boolean onScaleBegin(ScaleGestureDetector detector) {
            mScaleFactor = detector.getCurrentSpan();
            //一定要返回true才会进入onScale()这个函数
            return true;
        }

        @Override
        public void onScaleEnd(ScaleGestureDetector detector) {
            mScaleFactor = detector.getCurrentSpan();
        }
    }

    //自定义相机View中定义方法
    //放大
    public void zoomOut() {
        Camera.Parameters parameters = camera.getParameters();
        if (!parameters.isZoomSupported()) return;

        int zoom = parameters.getZoom() + 1;
        if (zoom < parameters.getMaxZoom()) {
            parameters.setZoom(zoom);
            camera.setParameters(parameters);
        }
    }

    //缩小
    public void zoomIn() {
        Camera.Parameters parameters = camera.getParameters();
        if (!parameters.isZoomSupported()) return;

        int zoom = parameters.getZoom() - 1;
        if (zoom >= 0) {
            parameters.setZoom(zoom);
            camera.setParameters(parameters);
        }
    }
```

预览使用Dialog，还有前后摄像头拍照方向问题
```
        //bitmap旋转90度
        Matrix matrix = new Matrix();
        matrix.setRotate(90);
        Bitmap waterMarkBitmap = Bitmap.createBitmap(waterMarkBitmap, 0, 0, waterMarkBitmap.getWidth(), waterMarkBitmap.getHeight(), matrix, true);
```
项目源码 https://github.com/Lrxc/CustomCamera.git

测试的Demo





