import sys 
sys.path.append("../")
from DAL.CONN import inventario,bancoSQL
from LOG.logs_APP import logDatabase
from DAL.blk import showSqlServerVersions,searchSQLogins,listAllSqlDatabase,dropSqlUser,searchSQLUser,dropSqlogin
import pandas as pd

a = pd.DataFrame({'CONNECT_STRING': [],'BUSCA': [],'VERSAO': []})


# Dataframe das CONNECT_STRING
with open('../logins.txt','r') as f:
     for line in f.readlines():
          data = line.rstrip()
          user,_servidor = data.split(",")
          a = a.append({'CONNECT_STRING': str(_servidor),'BUSCA': str(user),'VERSAO': str('SQL 2000')}, ignore_index=True)  
# --------------------------------------------------------------------------------- 
     

#configurando o los dos erros de banco de dados
_log = logDatabase()

 
 
# Sinaliza que existe algum usuario para apagar, e preciso apagar tambem o login

login_flag = 0
_busca=''

for i in range(0,len(a)):                 
        s = searchSQLogins(a['CONNECT_STRING'].values[i],a['BUSCA'].values[i],a['VERSAO'].values[i])   
        _busca = a['BUSCA'].values[i]
        if s :
            login_flag = 1
            db = listAllSqlDatabase(a['CONNECT_STRING'].values[i])
            for j in range(0,len(db)):                 
                l = searchSQLUser(db['SERVIDOR'].values[j],_busca,db['DATABASES'].values[j])
                if l :
                  #  dropSqlUser(a['CONNECT_STRING'].values[i] ,_busca,db['DATABASES'].values[j]) 
                  print(f'achou usuario: {_busca}')                  
        if login_flag == 1:
            #dropSqlogin(a['CONNECT_STRING'].values[i],_busca)
            print(f'achou login:  {_busca}')
            login_flag = 0  

