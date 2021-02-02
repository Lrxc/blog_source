---
title: SpringBoot-Oracle 存储过程
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


## 环境及版本：

- SpringBoot： 2.x
- Oracle : 11c



1. 无参数的存储过程

   创建存储过程

   ```
   create or replace procedure TEST01
   as
   begin
     dbms_output.put_line('hello word');
   end;
   ```

   Mapper.xml

   ```
   <select id="show1" statementType="CALLABLE" >
      {call TEST01}
   </select>
   ```

   Mapper.java

   ```
   void show1()
   ```

   Controller.java

   ```
   @Test
   public void show1() {
   	mapper.show1();
   }
   ```

2. 有参数的存储过程
    创建存储过程

   ```
   CREATE OR REPLACE 
   procedure TEST02(name in varchar,res out varchar)
   as
   begin
     dbms_output.put_line('name='||name);
     res:='name='||name;
end;
   ```

   Mapper.xml
   
   ```
   <select id="show2" statementType="CALLABLE" resultType="java.util.Map">
       {call TEST02 (#{name,mode=IN,jdbcType=VARCHAR},#{res,mode=OUT,jdbcType=VARCHAR})}
</select>
   ```

   Mapper.java
   
   ```
void show2()
   ```

   Controller.java
   
   ```
   @Test
   public void show2() {
   	Map<String,Object> map=new HashMap<>();
   	map.put("name","wahhh");
       batchManageMapper.show2(map);
       System.out.println(map.get("res"));
    }
   ```
   
3. 存储过程的结果集调用
   创建存储过程

   ```
   CREATE OR REPLACE 
   Procedure TEST03(res out sys_refcursor)
   As
   begin
   	open res for select * from BOND_INFO WHERE BOND_CODE='111799852.IB';
   End;
   ```

   Mapper.xml

    ```
   <resultMap id="resultMap" type="cn.com.pojo.BondInfo">
           <result property="bondCode" column="BOND_CODE"/>
           <result property="bondName" column="BOND_NAME"/>
   </resultMap>

   <select id="show3" statementType="CALLABLE" resultType="java.util.Map">
           {call TEST03 (#{res,mode=OUT,jdbcType=CURSOR,javaType=java.sql.ResultSet,resultMap=resultMap})}
   </select>
    ```

   Mapper.java
   
   ```
   List<BondInfo> show3(Map<String, Object> map);
   ```
   
   Controller.java
   ```
   @Test
   public void show3() {
     Map<String,Object> map=new HashMap<>();
     batchManageMapper.show3(map);
     List<BondInfo> bondInfos1 = (List<BondInfo>) map.get("res");
     System.out.println(bondInfos1.size());
   }
   ```
   
   
