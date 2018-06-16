--统计每个genre下的电影数量
use movielen;
select genre, count(*) as movie_num from movie_genre group by genre
