--列出观影用户数量超过一定阈值（自定）且平均用户评分排在最高（最低）前十的电影
use movielen;

--建立电影-观影人数表

select movieid, cast(count(userid) as float) as pnum into movie_pnum
from (
	select userid, movieid
	from Ratings
	union
	select userid, movieid
	from Tags
) as R1
group by movieid



--计算每部电影的观影用户均值、标准差
--select avg(pnum), stdev(pnum) from movie_pnum

--只考虑观影人数超过100的电影，评分前10有《教父》，《辛德勒名单》等电影
select top 10 Ratings.movieid, title, avg(rating) as avg_rating
from Ratings, movie_pnum, Movie
where Ratings.movieid = movie_pnum.movieid and movie_pnum.pnum > 100 and Ratings.movieid = Movie.movieid
group by Ratings.movieid, title
order by avg(rating) desc

--评分最低的10部电影
select top 10 Ratings.movieid, title, avg(rating) as avg_rating
from Ratings, movie_pnum, Movie
where Ratings.movieid = movie_pnum.movieid and movie_pnum.pnum > 100 and Ratings.movieid = Movie.movieid
group by Ratings.movieid, title
order by avg(rating) asc