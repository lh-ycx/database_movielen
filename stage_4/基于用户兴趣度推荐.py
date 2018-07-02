import pymssql
from os import getenv

class MSSQL:
    def __init__(self, host, user, pwd, db):
        self.host = host
        self.user = user
        self.pwd = pwd
        self.db = db

    def __GetConnect(self):
        if not self.db:
            raise(NameError, "没有设置数据库信息")
        #print('get here1!')
        self.conn = pymssql.connect(
            host=self.host, user=self.user, password=self.pwd, database=self.db, charset="utf8",as_dict=True)
        #print('get here2!')
        cur = self.conn.cursor()
        if not cur:
            raise(NameError, "连接数据库失败")
        else:
            return cur

    def ExecQuery(self, sql):
        cur = self.__GetConnect()
        cur.execute(sql)
        resList = cur.fetchall()

        # 查询完毕后必须关闭连接
        self.conn.close()
        return resList

    def ExecNonQuery(self, sql):
        cur = self.__GetConnect()
        cur.execute(sql)
        self.conn.commit()
        self.conn.close()


if __name__ == '__main__':
    #链接数据库
    ms = MSSQL(host="127.0.0.1", user="sa", pwd="sa", db="movielen")
    
    #创建新表avg_rating，存储每个电影的平均分。（只需要运行一次，因此注释掉）
    #ms.ExecNonQuery('create table avg_rating(movieId int, rating float)')
    #ms.ExecNonQuery('insert into avg_rating select movieId,avg(rating) rating from dbo.Ratings group by movieId order by movieId')
    
    usrid = input("please input the usrid:")
    #寻找用户对哪种类型的电影评分比较高，选前三
    reslist = ms.ExecQuery("""  select top 3 genre ,avg(rating) avg_rating 
                                from dbo.Ratings,dbo.movie_genre 
                                where Ratings.movieId = movie_genre.movieId 
                                and userId = """+ usrid +
                                "group by genre order by avg_rating desc")
    

    #推荐他还没看过的这种类型的高分电影，每一种类推荐前三个
    if reslist :
        #print(reslist)
        for row in reslist:
            print("推荐类型："+row['genre'])
            tempres = ms.ExecQuery("""  select top 5 movie_title_pub_date.movieId, title,rating 
                                        from dbo.movie_title_pub_date,dbo.movie_genre,dbo.avg_rating 
                                        where movie_title_pub_date.movieId = movie_genre.movieId 
                                        and movie_genre.movieId = avg_rating.movieId 
                                        and not exists (
                                            select * from Ratings
                                            where Ratings.movieId = movie_title_pub_date.movieId
                                            and Ratings.userId = """ + usrid +
                                        """
                                        )
                                        and movie_genre.genre = \'""" + row['genre'] + 
                                        "\' order by rating desc")
            print('movieId\ttitle\trating')
            for res in tempres:
                print(res['movieId'],res['title'],res['rating'])
    
    else :
        print('user '+usrid+' does not exist!')
        