---
title: Android-Fragment-嵌套使用
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


1 setUserVisibleHint
只有fragment与viewpager配合使用，才会调用
3 onHiddenChanged的回调时机
当使用add()+show()，hide()跳转新的Fragment时，旧的Fragment回调onHiddenChanged()，不会回调onStop()等生命周期方法，而新的Fragment在创建时是不会回调onHiddenChanged()，这点要切记。
