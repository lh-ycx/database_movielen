use movielen
--创建三个表格:PID2Usrid,MID2Movieid,Usr_Movie
create table PID2Usrid(
	PID int,
	usrid int
)
create table MID2Movieid(
	MID int,
	movieid int
)
create table Usr_Movie(
	PID int,
	MID int,
	rating float
)


--为usrid分配连续的唯一标识UID
declare @i int
declare @usrid int
set @i = 1
declare my_curs cursor for
	select distinct userid
	from dbo.Ratings
	order by userid ASC
open my_curs
fetch next from my_curs into @usrid
while @@FETCH_STATUS = 0
	begin 
		insert into PID2Usrid select @i, @usrid
		set @i =@i +1
		fetch next from my_curs into @usrid
	end
close my_curs
deallocate my_curs

--为movieid分配连续的唯一标识MID
declare @movieid int
set @i = 1
declare my_curs cursor for
	select distinct movieId
	from dbo.Movie
	order by movieId ASC
open my_curs
fetch next from my_curs into @movieid
while @@FETCH_STATUS = 0
	begin 
		insert into MID2Movieid select @i, @movieid
		set @i =@i +1
		fetch next from my_curs into @movieid
	end
close my_curs
deallocate my_curs


--用户电影关联矩阵
--declare @usrid int
--declare @movieId int
declare @PID int
declare @MID int
declare @rating float
declare my_curs cursor for
	select userId, movieId , rating 
	from Ratings
open my_curs
fetch next from my_curs into @usrid, @movieId, @rating
while @@FETCH_STATUS = 0
	begin
		select @PID = PID 
		from PID2Usrid
		where usrid = @usrid

		select @MID = MID
		from MID2Movieid
		where movieid = @movieId 	

		insert into Usr_Movie select @PID, @MID, @rating
		fetch next from my_curs into @usrid, @movieId, @rating
	end
close my_curs
deallocate my_curs