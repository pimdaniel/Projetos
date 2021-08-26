import pandas as pd
import sys
sys.path.append("../")
from DAL.CONN import bancoSQL
from DAL.blk import showSqlServer


path = r"../lista_backup.xlsx"
df = pd.DataFrame({'Servidores': []})
df2 = pd.DataFrame({'instancia':[],'base': [],'recovery': []})

 

df = showSqlServer() # Dataframe das CONNECT_STRING
 

sql = "select name, convert(varchar(30),databasepropertyex(name, 'Recovery')) as RecoveryModel from master.dbo.sysdatabases where convert(varchar(30),databasepropertyex(name, 'Recovery')) = 'Simple' order by name,databasepropertyex(name, 'Recovery')"


for i in df:
    _servidor=str(df[0]).replace("'", "").replace("(", "").replace(")", "").replace(",", "").replace('\\\\','\\') 
    #print('--> Servidor : '+ _servidor) # Print a connection_string  
    with bancoSQL(_servidor,'master') as cur: 
       
        cur.execute(sql)
        query = list(cur.fetchall())
        for rows in  query:
                df2 = df2.append({ 'instancia': str(_servidor),'base': str(rows[0]),'recovery': str(rows[1]) }, ignore_index=True)                  
            
        
    df2.to_excel(path,sheet_name='databases',index=False)
################################################################
 
 

