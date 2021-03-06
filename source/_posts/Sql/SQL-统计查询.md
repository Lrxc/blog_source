---
title: SQL-统计查询
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


```

-- 今天
select * from sp_pass_record where to_days(pass_time) = to_days(now());
	
-- 一周	
select sex ss,COUNT(*) from sp_pass_record  where DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date(pass_time) group by ss;

-- 按天统计
select DATE_FORMAT('2020-01-11','%Y%-%m-%d') days,count(*) count from sp_pass_record group by days;

-- 按周统计
select DATE_FORMAT('2020-01-10 18:31:37','%Y-%u') weeks,count(*) count from sp_pass_record group by weeks;

-- 按月统计
select DATE_FORMAT('2020-01-10 18:31:37','%Y-%m') months,count(*) count from sp_pass_record group by months;

-- 统计最近七天内的数据并按天分组
SELECT
	DATE_FORMAT(pass_time, '%Y-%m-%d' ) days,
	count(*) count 
FROM
(SELECT * FROM sp_pass_record WHERE DATE_SUB(CURDATE(), INTERVAL 7 DAY ) <= date(pass_time) ) as da
GROUP BY days;


-- 查询一天中每一个小时的记录数量
SELECT DATE_FORMAT(pass_time, '%k' ) hour,count(*) count 
FROM (select * from sp_pass_record where to_days(pass_time) = to_days(now())) as da
GROUP BY hour;

-- 查询一天中每一个小时的记录数量
SELECT HOUR(e.pass_time) as Hour,count(*) as Count 
FROM sp_pass_record e 
WHERE e.pass_time >= str_to_date('2020-01-17 00:00:00','%Y-%m-%d %T') AND e.pass_time < str_to_date('2020-01-17 23:59:59','%Y-%m-%d %T') 
GROUP BY HOUR(e.pass_time) ORDER BY Hour(e.pass_time)


-------------------------------------------------------------------------------------------------------------------


-- 24小时统计
SELECT DATE_FORMAT(pass_time, '%k' ) hour,count(*) count 
FROM sp_pass_record where to_days(pass_time) = to_days(now())-2
GROUP BY hour;


select @num:=@num+1,date_format(adddate('2020-01-19', INTERVAL @num HOUR),'%k') as hour
from sp_pass_record,(select @num:=0) t 
where adddate('2020-01-19', INTERVAL @num HOUR) <= date_format('2020-01-20','%Y-%m-%d')

-- 24小时补全
select @num:=@num+1,date_format(adddate(now(), INTERVAL @num HOUR),'%k') as hour
from sp_pass_record,(select @num:=0) t 
where adddate(now(), INTERVAL @num HOUR) <= date_format('2020-01-20','%Y-%m-%d')


SELECT a.num,a.hour,b.hour,IFNULL(b.count,0) count FROM 
(select @num:=@num+1 as num,date_format(adddate('2020-01-18', INTERVAL @num HOUR),'%k') as hour 
from sp_pass_record,(select @num:=0) t 
where adddate('2020-01-18', INTERVAL @num HOUR) <= date_format('2020-01-19','%Y-%m-%d')
) a 
LEFT JOIN 
(SELECT DATE_FORMAT(pass_time, '%k' ) hour,count(*) count 
FROM sp_pass_record 
where pass_time BETWEEN '2020-01-17' and '2020-01-18' GROUP BY hour
) b
on a.hour = b.hour
 
 



```
