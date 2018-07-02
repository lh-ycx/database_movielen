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
    
    usrid = input("please input the usrid(from 211914 to 221853):")

    #寻找于该用户最相近的三个用户
    reslist = ms.ExecQuery("""  select top 3 PID_2
                                from dbo.Usr_Similarity
                                where PID_1 = """+ usrid +
                                "order by similarity desc")
    

    #推荐他还没看过的其他人看的高分电影，每一个相似的用户推荐前3个
    if reslist :
        print(reslist)
        for row in reslist:

    
    else :
        print('user '+usrid+' does not exist!')
        