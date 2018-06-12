use movielen
--转为上映日期表
/*select movieId, substring(title, 0, len(title) - 5) as title, substring(title, PATINDEX('%([0-9][0-9][0-9][0-9])%', title) + 1, 4) as pub_date
into movie_title_pub_date from Movie;*/


update Movie set genres = genres +'|';
with movie_genres as (
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
  from movie_genres
  where sta != 0)

--select * from moveId_genres;

select movieId, substring(genres, sta - lens, lens) as genre into movie_genre  from movie_genres
where sta != 0 order by movieId ;
