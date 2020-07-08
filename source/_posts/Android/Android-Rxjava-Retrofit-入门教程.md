---
title: Android-Rxjava-Retrofit-入门教程
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


首先会Rxjava和Retrofit基本使用
Rxjava入门使用：http://www.jianshu.com/p/43a6ff622c54
Retrofit入门使用：http://www.jianshu.com/p/12a1ca7e428f

一。 添加依赖
```
compile 'com.squareup.retrofit2:retrofit:2.3.0'
compile 'com.squareup.retrofit2:converter-gson:2.3.0' //请求结果直接转化为实体类，省略gson转化
compile 'com.squareup.retrofit2:adapter-rxjava:2.3.0' //支持Rajava
compile 'io.reactivex:rxjava:1.3.0'
compile 'io.reactivex:rxandroid:1.2.1'
```

二。  定义Retrofit接口
```
//完整地址: http://www.wuhaojun.com/api/android/customer?type=1
public interface CustomerService {
    @GET("/api/android/customer")
    Observable<Customer> getCustomer(@Query("type") int type);//定义参数type的当前是第几页 1,2,3 ...
}
```
对比Retrofit定义的接口可以看到 就是把Call换成了Observable....

三 。  调用方法
```
String baseUrl = "http://www.wuhaojun.com/";
Retrofit retrofit = new Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create())//返回值直接转化实体类
        .addCallAdapterFactory(RxJavaCallAdapterFactory.create())//添加RxJava支持
        .build();

CustomerRjService service = retrofit.create(CustomerRjService.class);//创建对象
service.getCustomer(1)//传递参数
        .subscribeOn(Schedulers.io())//分配订阅者在子线程
        .observeOn(AndroidSchedulers.mainThread())//Toast时回到主线程
        .subscribe(new Action1<Customer>() {
            @Override
            public void call(Customer customer) {
                Toast.makeText(MainActivity.this, "完成  " + customer.getCode() + "---" + customer.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
```

四 附录：常用地址定义 
```
    //----------------------------------- 分割线 以下是Retrofit -------------------------------------//

    /**
     * retrofit get
     */
    @GET
    Call<ResponseBody> reGet(@Url String url);

    /**
     * post json
     */
    @POST
    Call<String> reJson(@Url String url, @Body RequestBody body);

    /**
     * post params 必须FormUrlEncoded
     */
    @POST
    @FormUrlEncoded
    Call<String> reParams(@Url String url, @FieldMap Map<String, String> map);

    /**
     * post file map
     */
    @POST
    @Multipart
    Call<String> reUploadFile(@Url String url, @PartMap Map<String, RequestBody> map);

    //----------------------------------- 分割线 以下是RxJava -------------------------------------//

    /**
     * rxjava get
     */
    @GET
    Observable<ResponseBody> rxGet(@Url String url);

    /**
     * post json
     */
    @POST
    Observable<String> rxJson(@Url String url, @Body RequestBody body);

    /**
     * post params
     */
    @POST
    @FormUrlEncoded
    Observable<String> rxParams(@Url String url, @FieldMap Map<String, String> map);

    /**
     * post file map
     */
    @POST
    @Multipart
    Observable<String> rxUploadFile(@Url String url, @PartMap Map<String, RequestBody> map);
```
调用方法
```
        //post json
        String json = "";
        RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json;charset=utf-8"), json);

        //post params
        HashMap<String, String> map = new HashMap<>();
        map.put("user", "test");

        //json file map
        File file = new File("");
        Map<String, RequestBody> hashMap = new HashMap<>();
        hashMap.put("json", RequestBody.create(MediaType.parse("text/plain"), "jsonargs"));//键值对
        hashMap.put("file\"; filename=\"" + file.getName(), RequestBody.create(MediaType.parse("multipart/form-data"), file));//文件
```

这就是最基本的Rxjava+Retrofit使用了，怎么样？是不是特别简单。。。
当然，这仅仅是最最简单的入门而已，深度的学习还是靠自己哈
大神tough1985文章：http://gank.io/post/56e80c2c677659311bed9841
