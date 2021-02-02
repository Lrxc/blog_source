---
title: Android-ToolBar
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />






    private void initToolbar() {
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        toolbar.setTitle("匹配结果");
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);//显示返回按钮
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        //1、组别，如果不分组的话就写Menu.NONE,
        //2、Id，这个很重要，Android根据这个Id来确定不同的菜单
        //3、顺序，哪个菜单项在前面由这个参数的大小决定
        //4、文本，菜单项的显示文本
        menu.add(Menu.NONE, 1, 0, "重新匹配").setShowAsAction(MenuItem.SHOW_AS_ACTION_IF_ROOM);
        //menu 布局
        getMenuInflater().inflate(R.menu.recycled, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                finish();
                break;
            case 1:
                initHttp();
                break;
        }
        return super.onOptionsItemSelected(item);
    }