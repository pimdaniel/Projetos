import sys 
sys.path.append("../")
from DAL.CONN import inventario,bancoSQL
from LOG.logs_APP import logDatabase
from DAL.blk import showSqlServerVersions,searchSQLogins,listAllSqlDatabase,dropSqlUser,searchSQLUser,dropSqlogin
import pandas as pd

#configurando o los dos erros de banco de dados
_log = logDatabase()

''''Usuario a ser apagado'''
_busca = 'apaga01'


# Dataframe das CONNECT_STRING
a = showSqlServerVersions()
# Sinaliza que existe algum usuario para apagar, e preciso apagar tambem o login
login_flag = 0


for i in range(0,len(a)):         
        
        s = searchSQLogins(a['CONNECT_STRING'].values[i],_busca,a['VERSAO'].values[i])        
        if s :
            login_flag = 1
            db = listAllSqlDatabase(a['CONNECT_STRING'].values[i])
            for j in range(0,len(db)):                 
                l = searchSQLUser(db['SERVIDOR'].values[j],_busca,db['DATABASES'].values[j])
                if l :
                    dropSqlUser(a['CONNECT_STRING'].values[i] ,_busca,db['DATABASES'].values[j])                   
        if login_flag == 1:
            dropSqlogin(a['CONNECT_STRING'].values[i],_busca)
            login_flag = 0  

           
             



 