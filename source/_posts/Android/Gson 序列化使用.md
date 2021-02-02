---
title: Gson 序列化使用
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


gson 注解 一个字段对应多个名字  

    @SerializedName(value = "proposal_no", alternate = {"proposalNo"})
    pritvate String name;
    @SerializedName("title")
    pritvate String age;
    
gson 解析数组
    
      List<String> list = gson.fromJson("", new TypeToken<List<String>>() {
        }.getType());