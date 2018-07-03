use movielen;
create index genres_index on movie_genre(movieId)
go

-- 执行语句部分
select genre, count(*) as movie_num from movie_genre group by genre
go

dbcc dropcleanbuffers --清除各缓存
dbcc freeproccache

SET STATISTICS PROFILE ON 
SET STATISTICS IO ON 
SET STATISTICS TIME ON 
GO

-- 执行语句部分
select genre, count(*) as movie_num from movie_genre group by genre

GO
SET STATISTICS PROFILE OFF 
SET STATISTICS IO OFF 
SET STATISTICS TIME OFF
