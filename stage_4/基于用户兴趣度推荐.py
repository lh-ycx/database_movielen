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
        print('get here1!')
        self.conn = pymssql.connect(
            host=self.host, user=self.user, password=self.pwd, database=self.db, charset="utf8")
        print('get here2!')
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
    ms = MSSQL(host="127.0.0.1", user="sa", pwd="sa", db="movielen")
    reslist = ms.ExecQuery("select top 1000 * from dbo.Movie")
    for i in reslist:
        print(i)
