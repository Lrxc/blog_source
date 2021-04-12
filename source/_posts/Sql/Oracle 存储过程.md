---
title: Oracle 存储过程
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


#### 作用：

存储过程是一组为了完成特定功能的SQL语句，经编译后存储在数据库中。

#### 示例

- 示例1：打印hello world

  ```sql
  ***第一个存储过程：打印hello word, my name is stored procedure内容***
  create or replace procedure test01
  as
  begin
    dbms_output.put_line('hello word, my name is stored procedure');
  end;
  ```
  **create or replace procedure**：关键字用来创建或覆盖一个原有的存储过程
  **test01**：自定义的存储过程的名字
  **as**：关键字
  **begin**：关键字
  **dbms_output.put_line**(‘’); 打印内容
  **end; ** 关键字

- 示例2：变量声明，赋值

  ```
  create or replace procedure test02
  as
    name varchar(10);--声明变量，注意varchar需要指定长度
    age int;
  begin
    name:='xiaoming';--变量赋值
    age:=18;
    dbms_output.put_line('name='||name||', age='||age);--通过||符号达到连接字符串的功能
  end;
  ```

- 示例3 ：实参形参问题

  ```
  create or replace procedure test04(name in varchar,age in int)
  as
  begin
    dbms_output.put_line('name='||name||', age='||age);
  end;
  
  --调用上面的
  CREATE OR REPLACE PROCEDURE test
  AS
   name varchar(20);
   res varchar(200);
  begin
    name:='xiaoming';
    --test04('xiaoming',18);
    test04(name=>name,age=>age,res=>res);--此时不能test04(name=>name,18)，不能完成调用。
  end;
  ```

  注;在调用存储过程时，=>前面的变量为存储过程的形参且必须于存储过程中定义的一致，而=>后的参数为实际参数。当然也不可以不定义变量保存实参

- 示例4：in，out参数问题

  ```
  create or replace procedure test05(name out varchar,age in int)
  as
  begin
    dbms_output.put_line('age='||age);
    select 'xiaoming' into name from dual;
  end;
   
   
  --调用上面的
  CREATE OR REPLACE PROCEDURE test
  AS
    name varchar(10);
    age int;
  begin
    test05(name=>name,age=>10);
  dbms_output.put_line('name='||name);
  end;
  ```
  
  **注：in代表输入，out用于输出**

- 示例5 ：异常处理

  ```
  create or replace procedure test06
  as
  age int;
  begin
    DBMS_OUTPUT.ENABLE(1000000); --错误：buffer overflow, limit of 20000 bytes
    age:=10/0;
    dbms_output.put_line(age);
  exception 
    when others then
  	--打印详细错误信息
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode||' sqlerrm : ' ||sqlerrm);
  	DBMS_OUTPUT.put_line('error_trace'||dbms_utility.format_error_backtrace);
  	exit;
  end;
  ```

  ```
  CREATE OR REPLACE 
  procedure     TEST02
  AS
  resstr VARCHAR2(100);
  
  BEGIN
   Execute immediate 'select * from dual' into resstr;
   dbms_output.put_line('数据是:'||resstr);
  END;
  ```

- 示例6 ：集合查询、循环、游标
遍历方式1
  ```
  CREATE OR REPLACE 
  procedure TEST61
  AS
  	--游标的定义
  	Cursor test_cursor is select * from BOND_INFO WHERE BOND_CODE='111799852.IB';
  	cur test_cursor%rowtype;  --游标的类型，理解类似于list的泛型
  BEGIN
  	for cur in test_cursor loop
  		exit when test_cursor%notfound;
  		dbms_output.put_line('数据是:'||cur.BOND_CODE);
  	end loop;
  END;
  ```

  遍历方式2
  
  ```
  CREATE OR REPLACE 
  Procedure TEST62(res out Sys_Refcursor)
  As
  	--引用数据类型
  	cur BOND_INFO%rowtype; 
  begin
  	--查询结果保存到游标中
  	open res for select * from BOND_INFO WHERE BOND_CODE='111799852.IB';
  	DBMS_OUTPUT.put_line('游标长度-- '||c_finance_quota1%rowcount);
  
  	--open res;--打开游标,上面已打开
  	loop --开始循环
  		FETCH res INTO cur; --读取游标中数据
  		exit when res%notfound; --退出条件
  		dbms_output.put_line('数据是:'||cur.BOND_CODE);
	end loop; --结束循环
  End;
  ```
  
  7动态sql
  
  ```
  CREATE OR REPLACE 
  procedure     TEST02
  AS
  resstr VARCHAR2(100);
  
  BEGIN
   Execute immediate 'select * from dual' into resstr;
   dbms_output.put_line('数据是:'||resstr);
  END;
  ```
  
  