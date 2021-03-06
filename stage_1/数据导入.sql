/* stage 1.1导入数据并生成初始表 */

use movielen
create table Movie(
	movieId  int ,
	title nvarchar(max),
	genres nvarchar(max)
)
create table Tags
(
	userId int,
	movieId int,
	tag nvarchar(max),
	timestamp int
)

create table Ratings
(
	userId int,
	movieId int,
	rating float,
	timestamp int
)

BULK INSERT Movie
FROM  'C:\Users\ycx\Desktop\数据库概论\大作业\ml-latest\movies.csv'
WITH
(
    FORMAT = 'CSV', 
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
	datafiletype='widechar',
    CODEPAGE='65001',
    TABLOCK
)

BULK INSERT Tags
FROM 'C:\Users\ycx\Desktop\数据库概论\大作业\ml-latest\tags.csv'
WITH
(
    FORMAT = 'CSV', 
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
	datafiletype='widechar',
    CODEPAGE='65001',
    TABLOCK
)

BULK INSERT Ratings
FROM 'C:\Users\ycx\Desktop\数据库概论\大作业\ml-latest\ratings.csv'
WITH
(
    FORMAT = 'CSV', 
    FIELDQUOTE = '"',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
	datafiletype='widechar',
    CODEPAGE='65001',
    TABLOCK
)