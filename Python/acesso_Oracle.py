
import sys
sys.path.append("../")
from DAL.CONN import invConn,inventario
from LOG.logs_APP import logDatabase

#configurando o los dos erros de banco de dados
_log,_logFile  = logDatabase()

'''
# Maneira 01 ------------------------------------------------------------------------------------------
connection = invConn()

cursorL2 = connection.cursor()
sql = "select distinct CONNECT_STRING from  DATABASES_MSSQL where  TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ' order by CONNECT_STRING"

cursorL2.execute(sql)
 

for itens in cursorL2: 
      print(str(itens[0]) )

connection.close()
# ---------------------------------------------------------------------------------------------------------------------------------------
'''

# Maneira 02 ----------------------------------------------------------------------------------------------------------------------------

try: 
    with inventario() as cur:         
 
        sql = "select distinct CONNECT_STRING from  DATABASES_MSSQL where  TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ' order by CONNECT_STRING"
        cur.execute(sql)
        query = list(cur.fetchall())
        
        for itens in query: 
            print(str(itens[0]))

except Exception as e:
   _log.error(e)    
# ------------------------------------------------------------------------------------------------------------------------------------