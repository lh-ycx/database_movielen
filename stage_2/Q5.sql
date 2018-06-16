--在用户评分过的电影中，有些是打过标签的，有些则没有，比较一下用户在这两类电影评分上的不同
--比较“Ratings except Tags”和“Ratings intersect Tags”电影评分

use movielen;

--只有评分的电影评分：3.47 ± 1.06
with only_rating as(
	select movieid
	from Ratings
	except
	select movieid
	from Tags
)
select avg(rating), stdev(rating)
from only_rating, Ratings
where only_rating.movieid = Ratings.movieid;

--既有评分又有tag的电影 3.81 ± 0.99
with rating_tag as(
	select movieid
	from Ratings
	intersect
	select movieid
	from Tags
)
select avg(rating), stdev(rating)
from rating_tag, Ratings
where rating_tag.movieid = Ratings.movieid
