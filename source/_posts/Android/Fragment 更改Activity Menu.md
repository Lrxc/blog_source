---
title: Fragment 更改Activity Menu
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />



    oncreate() 中调用  
    setHasOptionsMenu(true);
    
    重写
    onPrepareOptionsMenu
    menu.clear();
    
    刷新Menu  
    getActivity().supportInvalidateOptionsMenu();