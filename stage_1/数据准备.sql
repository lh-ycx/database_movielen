use movielen

--将Tags表中的时间戳timestamp转为数据库中的日期
select userId,movieId,tag,DATEADD(s, timestamp+8*3600, '1970-01-01 00:00:00') time
into newtags
from Tags

--将Ratings表中的时间戳timestamp转为数据库中的日期
select userId,movieId,rating,DATEADD(s, timestamp+8*3600, '1970-01-01 00:00:00') time
into newratings
from Ratings


--转为上映日期表
select movieId, substring(title, 0, len(title) - 5) as title, substring(title, PATINDEX('%([0-9][0-9][0-9][0-9])%', title) + 1, 4) as pub_date
into movie_title_pub_date from Movie;


update Movie set genres = genres +'|';
with movieId_genres as (
  select
    movieId,
    genres,
    charindex('|', genres)     sta,
    charindex('|', genres) - 1 lens
  from Movie
  union all
  select
    movieId,
    genres,
    charindex('|', genres, sta + 1)             sta,
    charindex('|', genres, sta + 1) - sta - 1 lens
  from movieId_genres
  where sta != 0)

--select * from moveId_genres;

select movieId, substring(genres, sta - lens, lens) as genre into movieId_genre  from movieId_genres
where sta != 0 order by movieId ;
