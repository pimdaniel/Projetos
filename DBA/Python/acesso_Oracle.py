
from DAL import invConn  
 
connection = invConn()

cursorL2 = connection.cursor()
sql = "select distinct CONNECT_STRING from  DATABASES_MSSQL where  TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ' order by CONNECT_STRING"

cursorL2.execute(sql)
 

for itens in cursorL2: 
      print(str(itens[0]) )


connection.close()
