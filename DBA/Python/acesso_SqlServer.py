from DAL import labConn
from DAL import escreve
from DAL import mysqlConn
import pymssql
import pandas as pd


# _user = "sql_monit"
# _password = "Db@m0n!t"cls

# _server = "10.4.56.79\\SQLTELCOBI03"
#_server = "10.4.56.70"

_server = "10.2.20.33"
_db = "master"
_user = "da"
_password="da"

 

###################   RETORNA 1 LINHA       ###########################

#connectionL2 = pymssql.connect(_server, _user, _password, _db)
#cursorL2 = connectionL2.cursor()

#sql = "SELECT  name FROM SYSUSERS"
    # WHERE NAME"  
    #   ='"+_login+"'"
#cursorL2.execute(sql)
#data = cursorL2.fetchone()

#print(data)

#cursorL2.close()
#connectionL2.close()
################################################################################ # list(cursorL2.fetchall()):

   # outF.write( str(itens[0]) + ";" + str(itens[1])  )    
   # outF.write("\n")
   #outF = open("myOutFile.txt", "w")
   #outF.close()

#########################   RETORNA VÁRIAS LINHAS   ##############

connection = labConn() 

cursorL2 = connection.cursor()
sql = "SELECT loginname,[language]   FROM syslogins"

cursorL2.execute(sql)
 

for itens in cursorL2: 
      print(str(itens[0]) )


connection.close()

################################################################
 
 
