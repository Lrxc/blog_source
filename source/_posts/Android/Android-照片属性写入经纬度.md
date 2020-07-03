---
title: Android-照片属性写入经纬度
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


![image.png](http://upload-images.jianshu.io/upload_images/2803682-a754be67f99fa5b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

拍照后保存到本地文件，借助ExifInterface
保存格式必须是JPEG，否则不支持写入编辑
```
bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
```

写入方法很简单
```
try {
    //保存照片的经纬度信息
    ExifInterface exif = new ExifInterface(file.getAbsolutePath());
    exif.setAttribute(ExifInterface.TAG_GPS_LATITUDE, ConvertUtils.convertToDegree(116.2353515625));
    exif.setAttribute(ExifInterface.TAG_GPS_LONGITUDE, ConvertUtils.convertToDegree(39.5379397452));
    exif.saveAttributes();
    //打印结果
    String latValue = exif.getAttribute(ExifInterface.TAG_GPS_LATITUDE);
    String lngValue = exif.getAttribute(ExifInterface.TAG_GPS_LONGITUDE);
    Log.i(TAG, "onCameraData: " + ConvertUtils.convertToCoordinate(latValue) + "--" + ConvertUtils.convertToCoordinate(lngValue));
} catch (IOException e) {
    e.printStackTrace();
}
```

ConvertUtils 工具类
```
public class ConvertUtils {
    //经纬度转度分秒
    public static String convertToDegree(double gpsInfo) {
        String dms = Location.convert(gpsInfo, Location.FORMAT_SECONDS);
        return dms;
    }

    //度分秒转经纬度
    public static Double convertToCoordinate(String stringDMS) {
        if (stringDMS == null) return null;
        String[] split = stringDMS.split(":", 3);
        return Double.parseDouble(split[0]) + Double.parseDouble(split[1]) / 60 + Double.parseDouble(split[2]) / 3600;
    }
}
```

搞定。 最后别忘了文件读写权限


