import sys
sys.path.append("../")
from DAL.CONN import mysqlConn,bancoMysql
from LOG.logs_APP import logDatabase

#configurando o los dos erros de banco de dados
_log,_logFile  = logDatabase()
 

# ----------------------- Maneira 01---------------------------------------
try: 
    conn =mysqlConn()

    cur = conn.cursor()

    sql="select user from mysql.user;"

    cur.execute(sql)


    for itens in cur: 
        print(str(itens[0]))
        
    conn.close()

except Exception as e:
   #_log.error(e)      
   print('erro acessar mysql')


# ----------------------- Maneira 02 ---------------------------------------
'''
try: 
    with bancoMysql("10.243.172.57","mysql") as cur:         
       
        sql = "SELECT user,host FROM mysql.user;"
        cur.execute(sql)
        
        #query = list(cur.fetchall())        
        
        for itens in cur: 
            print(str(itens[0]))

except Exception as e:
   #_log.error(e)      
   print(e)
'''