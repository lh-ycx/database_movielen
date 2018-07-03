drop table S
select movieId ,  avg(rating)as avg_rating into S
from  Ratings
group by movieId

drop table R
select S.movieId as movieId, genre, avg_rating as rating into R
from movie_genre, S
where movie_genre.movieId = S.movieId
select *
from R
