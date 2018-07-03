use movielen;

-- 执行语句部分
select genre, avg(rating) as avg_rating
from R
group by genre
go
set showplan_all off
go

dbcc dropcleanbuffers --清除各缓存
dbcc freeproccache

SET STATISTICS PROFILE ON 
SET STATISTICS IO ON 
SET STATISTICS TIME ON 
GO

-- 执行语句部分
select genre, avg(rating) as avg_rating
from R
group by genre

GO
SET STATISTICS PROFILE OFF 
SET STATISTICS IO OFF 
SET STATISTICS TIME OFF
