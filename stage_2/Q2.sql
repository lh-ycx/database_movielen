--统计每个genre下的平均用户评分
use movielen;

select genre, avg(rating) as avg_rating
from movie_genre, Ratings
where movie_genre.movieid = Ratings.movieid
group by genre