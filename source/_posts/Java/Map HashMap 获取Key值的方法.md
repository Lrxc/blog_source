---
title: Map HashMap 获取Key值的方法
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />




    List<Map<String, Fragment>> mDatas = new ArrayList<>();
    
        Map<String, Fragment> map1 = new ArrayMap<>();
        map1.put("首页", OneFragment.newInstance());
        
        Map<String, Fragment> map2 = new ArrayMap<>();
        map2.put("闪贷大全", TwoFragment.newInstance());
        
        Map<String, Fragment> map3 = new ArrayMap<>();
        map3.put("个人中心", ThreeFragment.newInstance());
        
        mDatas.add(map1);
        mDatas.add(map2);
        mDatas.add(map3);
        
        
        
    Iterator<String> iterator = mDatas.get(position).keySet().iterator();
    iterator.next()  //Key
    mDatas.get(position).get(iterator.next())  //Value
    
#### 方法1：keySet()
    Map<Character, Integer> map = new HashMap<>();

    for (char key : map.keySet()) {
        res += key + "" + map.get(key);
    }
    System.out.println(res);
    
    Iterator<Character> iterator11 = map.keySet().iterator();
    while (iterator11.hasNext()) {
        Character key = iterator11.next();
        res += key + "" + map.get(key);
    }
    System.out.println(res);

    
#### 方法2：entrySet() 效率高
    for (Map.Entry<Character, Integer> entry : map.entrySet()) {
        res += entry.getKey() + "" + entry.getValue();
    }
    System.out.println(res);

    Iterator<Map.Entry<Character, Integer>> iterator2 = map.entrySet().iterator();
    while (iterator2.hasNext()) {
        Map.Entry<Character, Integer> entry = iterator2.next();
        res += entry.getKey() + "" + entry.getValue();
    }
    System.out.println(res);