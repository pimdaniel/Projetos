from DAL import labConn,bancoSQL
from logs_APP import logDatabase
import pandas as pd

'''
App conecta no banco de dados e printa os valores das colunas em uma tabela, e se ocorreu algum erro ele  escreve este erro em um arquivo de LOG
'''


#configurando o los dos erros de banco de dados
_log = logDatabase()
 

try: 
    with bancoSQL("10.2.20.33\sqk2008",'master') as cur:         
 
        #cur = bancoSQL("10.2.20.33")

        sql = "SELECT loginname,[language]   FROM syslogins"
        cur.execute(sql)
        query = list(cur.fetchall())

        
        for itens in query: 
            print(itens[0])

except Exception as e:
   _log.error(e)        
  