--列出每个genre下观影用户数量超过一定阈值且平均用户评分排在最高（最低）前十的电影
use movielen;

--建立一个临时表，保存各genre下排名前10的电影
create table #genre_movie(
	genre nvarchar(max),
	movieid int,
	title nvarchar(max),
	rating float,
)

declare @genre nvarchar(max)
declare my_curs cursor for
	select distinct genre
	from movie_genre
open my_curs
fetch next from my_curs into @genre
while @@FETCH_STATUS = 0
begin
	insert into #genre_movie
	select top 10 movie_genre.genre, Ratings.movieid, title, avg(rating) as avg_rating
	from Ratings, movie_pnum, Movie, movie_genre
	where Ratings.movieid = movie_pnum.movieid
		and Ratings.movieid = Movie.movieid
		and Ratings.movieid = movie_genre.movieid 
		and movie_pnum.pnum > 100 
		and movie_genre.genre = @genre
	group by Ratings.movieid, movie_genre.genre, Movie.title
	order by avg(rating) desc
	fetch next from my_curs into @genre
end
close my_curs
deallocate my_curs

select * from #genre_movie
drop table #genre_movie