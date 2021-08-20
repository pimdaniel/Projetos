from DAL import labConn
from DAL import escreve
from DAL import sqlConnDbmon
import pymssql
import pandas as pd
from blk import showSqlServer

path = r"E:\Desenvolvimento\lista_backup.xlsx"

df = pd.DataFrame({'Servidores': []})

df2 = pd.DataFrame({'instancia':[],'base': [],'recovery': []})

 

df = showSqlServer() # Dataframe das CONNECT_STRING
 

sql = "select name, convert(varchar(30),databasepropertyex(name, 'Recovery')) as RecoveryModel from master.dbo.sysdatabases where convert(varchar(30),databasepropertyex(name, 'Recovery')) = 'Simple' order by name,databasepropertyex(name, 'Recovery')"

c=0
for i in df:
    _servidor=str(df[c]).replace("'", "").replace("(", "").replace(")", "").replace(",", "").replace('\\\\','\\') 
    print('--> Servidor : '+ _servidor) # Print a connection_string
    
    connection = sqlConnDbmon(_servidor,'master')
    cursorL2 = connection.cursor()
    cursorL2.execute(sql)
    for rows in cursorL2:
       #print(str(rows[0]) + ' -- ' + str(rows[1]) )       
       df2 = df2.append({ 'instancia': str(_servidor),'base': str(rows[0]),'recovery': str(rows[1]) }, ignore_index=True)
               
    c+=1    
    connection.close()   
    
    df2.to_excel(path,sheet_name='mysqlUsers',index=False)

 
################################################################
 
 

