use movielen

--建立用户用户关联矩阵
create table Usr_Similarity(
	PID_1 int,
	PID_2 int,
	similarity int		
)

--当用户看过的电影打分相近的话权重增加，打分相差很大的话权重减少，最低为0
insert into Usr_Similarity
select PID_1,PID_2,similarity
from 
(select R.PID_1, R.PID_2, case when R.similarity-S.similarity<0 then 0 else R.similarity-S.similarity end similarity
from (select T1.PID PID_1, T2.PID PID_2 ,count(*) similarity
	from Usr_Movie T1, Usr_Movie T2
	where T1.PID < T2.PID and T1.MID = T2.MID and abs(T1.rating - T2.rating) <=0.3 
	group by T1.PID, T2.PID) as R,
	(select T1.PID PID_1, T2.PID PID_2 ,count(*) similarity
	from Usr_Movie T1, Usr_Movie T2
	where T1.PID < T2.PID and T1.MID = T2.MID and abs(T1.rating - T2.rating) >1.0 
	group by T1.PID, T2.PID) as S
where R.PID_1=S.PID_1 and R.PID_2=S.PID_2) as T