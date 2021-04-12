---
title: Sql Mybatis 有则更新无则插入(批量)
date: 2021-03-01 10:01:33
categories: 
- sql
tags: [sql]

---

<meta name="referrer" content="no-referrer" />

#安装环境及版本：

- 系统：Mysql \ Oracle



# 一  基础表数据

```
CREATE TABLE `sys_user` (
  `id` varchar(100) primary key,
  `username` varchar(100) not null,
  `password` varchar(100) not null,
  `status` int not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```



# 二 Mysql 

## 1 批量插入

mapper 接口

```
/**
 * 批量新增数据（MyBatis原生foreach方法）
 *
 * @param entities List<SysUser> 实例对象列表
 * @return 影响行数
 */
int insertBatch(@Param("entities") List<SysUser> entities);
```

mapper xml

```
<insert id="insertBatch" keyProperty="id" useGeneratedKeys="true">
    insert into sys_user(id, username, password, status)
    values
    <foreach collection="entities" item="entity" separator=",">
        (#{entity.id}, #{entity.username}, #{entity.password}, #{entity.status})
    </foreach>
</insert>
```



## 2  有则更新 无则插入 单条

mapper 接口

```
/**
 * 新增或按主键更新数据（MyBatis原生foreach方法）
 *
 * @param entities 实例对象列表
 * @return 影响行数
 */
int insertOrUpdate(@Param("sysuser") SysUser sysuser);
```

mapper xml

```
<insert id="insertOrUpdate" keyProperty="id" useGeneratedKeys="true">
    insert into 
    sys_user(id, username, password, status)
    values
    (#{sysuser.id}, #{sysuser.username}, #{sysuser.password}, #{sysuser.status})
    on duplicate key update
    id = values(id) , username = values(username) , password = values(password) , status = values(status)
</insert>
```



## 3 有则更新 无则插入 批量

mapper 接口

```
/**
 * 批量新增或按主键更新数据（MyBatis原生foreach方法）
 *
 * @param entities List<SysUser> 实例对象列表
 * @return 影响行数
 */
int insertOrUpdateBatch(@Param("entities") List<SysUser> entities);
```

mapper xml

```
<insert id="insertOrUpdateBatch" keyProperty="id" useGeneratedKeys="true">
    insert into sys_user(id, username, password, status)
    values
    <foreach collection="entities" item="entity" separator=",">
        (#{entity.id}, #{entity.username}, #{entity.password}, #{entity.status})
    </foreach>
    on duplicate key update
    id = values(id) , username = values(username) , password = values(password) , status = values(status)
</insert>
```



# 三 Oracle

## 1 批量插入

mapper 接口

```
int insertBatch(List<SysUser> list);
```

mapper xml

```
<insert id="insertBatch" parameterType="java.util.List" >
  insert into sys_user(id, username, password, status)
  <!--oracle 没有values，只能这种-->
  select A.* from(
    <foreach collection="list" item="item" index="index" separator="union all">
      select
         #{item.id} id,
      	#{item.username} username,
      	#{item.password} password,
      	#{item.status} status
      from dual
    </foreach>
  )A
</insert>
```

## 2 有则更新 无则插入 单条

mapper 接口

```
int insertOrUpdateBatch(SysUser sysuser);
```

mapper xml

```
<!--批量插入或更新-->
<update id="insertOrUpdateBatch" parameterType="java.util.List" >
  merge into sys_user t1
  using (
    select
      #{sysuser.id} id,
      #{sysuser.username} username,
      #{sysuser.password} password,
      #{sysuser.status} status
    from dual
  ) t2
  on (t1.id=t2.id)
  when matched then
    update
    <set>
      <if test="username!=null">
        t1.username=#{sysuser.username},
      </if>
      <if test="password!=null">
        t1.password=#{sysuser.password},
      </if>
      <if test="status!=null">
      	<!--直接使用t2的值,待验证-->
        t1.status=t2.status,
      </if>
    </set>
  when not matched then
    insert (id, username, password, status)
    values (t2.id, t2.username, t2.password,t2.status)
</update>
```



## 3 有则更新 无则插入 批量

mapper 接口

```
int insertOrUpdateBatch(List<DefaultEnterprise> list);
```

mapper xml

```
<!--批量插入或更新-->
<update id="insertOrUpdateBatch" parameterType="java.util.List" >
  merge into sys_user t1
  using (
  <foreach collection="list" item="item" index="index" separator="union all">
    select
      #{item.id} id,
      #{item.username} username,
      #{item.password} password,
      #{item.status} status
    from dual
  </foreach>
  ) t2
  on (t1.id=t2.id)
  when matched then
    update
    <set>
      <if test="item.username!=null">
        t1.username=t2.username,
      </if>
       <if test="item.password!=null">
        t1.password=t2.password,
      </if>
       <if test="item.status!=null">
        t1.status=t2.status,
      </if>
    </set>
  when not matched then
    insert (id, username, password, status)
    values (t2.id, t2.username, t2.password,t2.status)
</update>
```

