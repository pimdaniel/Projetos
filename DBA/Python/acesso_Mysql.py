from DAL import mysqlConn

conn =mysqlConn()
cur = conn.cursor()

sql="select user from mysql.user;"

cur.execute(sql)


for itens in cur: 
    print(str(itens[0]))
    
conn.close()
