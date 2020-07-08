---
title: Android-Retrofit-入门教程
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


首先添加依赖
```
compile 'com.squareup.retrofit2:retrofit:2.3.0'
compile 'com.squareup.retrofit2:converter-gson:2.3.0'//请求结果直接转化为实体类，省略gson转化
```

创建一个接口
```
// 完整地址: http://www.wuhaojun.com/api/android/customer?type=1
public interface CustomerService {
    @GET("/api/android/customer")//Get请求地址
    Call<Customer> getCustomer(@Query("type") int type);//定义参数type的当前是第几页 1,2,3 ...
}
```

请求方法
```
        String baseUrl = "http://www.wuhaojun.com/";//请求地址，固定的一部分
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())//请求结果直接转化实体类
                .build();

        CustomerService movieService = retrofit.create(CustomerService.class);//创建对象
        Call<Customer> call = movieService.getCustomer(1);//传递请求参数 对应接口中的定义
        call.enqueue(new Callback<Customer>() {
            @Override
            public void onResponse(Call<Customer> call, Response<Customer> response) {
                Log.i(TAG, "onResponse: "+response.body().getMessage());//返回的就是实体类，不需要Gson转换
            }

            @Override
            public void onFailure(Call<Customer> call, Throwable t) {
                Log.i(TAG, "onFailure: "+t.getMessage());
            }
        });
```

最后，别忘了添加网络权限
```
<uses-permission android:name="android.permission.INTERNET" />
```

附加其他上传类型
```
//post json
    @POST
    Call<String> reJson(@Url String url, @Body RequestBody body);

	HashMap<String, String> params = new HashMap<>();
	params.put("phone_num", "123");
	JSONObject json = new JSONObject(params);
    RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json;charset=utf-8"), json);//转化类型


//post params
    @POST
    @FormUrlEncoded
    Call<String> reParams(@Url String url, @FieldMap Map<String, String> map);

	HashMap<String, String> hashMap = new HashMap<>();
    hashMap.put("user", "test");	
    
    
//post file map
    @POST
    @Multipart
    Call<String> reUploadFile(@Url String url, @PartMap Map<String, RequestBody> params);
    
    File file = new File("");
    Map<String, RequestBody> hashMap = new HashMap<>();
    hashMap.put("json", RequestBody.create(MediaType.parse("text/plain"), "jsonargs"));//键值对
    hashMap.put("file\"; filename=\"" + file.getName(), RequestBody.create(MediaType.parse("multipart/form-data"), file));//文件
```

大神tough1985文章：http://gank.io/post/56e80c2c677659311bed9841
