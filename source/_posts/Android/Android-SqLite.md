---
title: Android-SqLite
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />



## Sqlite
    
    //1.使用这种query方法%号前不能加' ;        
    Cursor c_test = mDatabase.query(tab_name, new String[]{tab_field02}, tab_field02+"  LIKE ? ",new String[] { "%" + str[0] + "%" }, null, null, null);


    //2.使用这种query方法%号前必须加' 
    "select * from " + TABLE_NAME + " where status= " + status+ " and accdientAddress like '%" + accdientAddress + "%' and insureName like '%" + insureName + "%' and outDate like '%" + outDate+"%'"
    
    //and or 组合(多个or需要括号)
    "select * form table where id=3 and (age>20 or adress="北京")"



##    OrmLite
   
    all = dao.queryBuilder().orderBy("Id", true).where().eq("Type", key).and().eq("owner", Pub.user.getAccount()).and().eq("UserType", Pub.user.getUserType()).query();  
    
    例如：
    sql="select top 18 id,schoolnam,img from schoolinfo order by num desc,id desc"
    表示 首先按照num 降序排列，当num相同时，按id降序排列
    
    
    
    
    
    
##     GreenDao
    
    
    List<FilePhoto> list = filePhotoDao.queryBuilder().where(FilePhotoDao.Properties.ImageName.eq(file.getName().substring(0, 8))).build().list();
    
    
    //Greendao的模糊查询需要对传人的值前后加"%"，如："%"+value+"%"；
    List<FilePhoto> lists = filePhotoDao.queryBuilder().where(FilePhotoDao.Properties.ImageName.like("%" + file.getName().substring(0, 8) + "%")).build().list();