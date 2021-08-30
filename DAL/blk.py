import cx_Oracle
import pymssql
import pandas as pd
import sys
sys.path.append("../")
from DAL.CONN import inventario
from DAL.CONN import inventario,bancoSQL,sqlConn
from LOG.logs_APP import logDatabase

#configurando o los dos erros de banco de dados
_log = logDatabase()

def showSqlServer():

    ''' Lista todos os servidores SQL Server de producao no Inventario '''

    #connection = cx_Oracle.connect('dbmon/monitor@p00inv')
    #cursor = connection.cursor()

    try: 
        with inventario() as cur:  

            cur.execute("select distinct CONNECT_STRING from  DATABASES_MSSQL where TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ'")
            query = list(cur.fetchall())                  

            l = list()  

            for itens in query:
                l.append(str(itens).replace("'", "").replace("(", "").replace(")", "").replace(",", ""))

    except Exception as e:
            _log.error(e)  
    
    
    return l

def showSqlServerSOX():
    
    with inventario() as cur:     

        ''' Servidores paro SOX '''
        _sql = "select distinct CONNECT_STRING from  DATABASES_MSSQL where SOX = 'Y' and TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ'"
        cur.execute(_sql)

        l = list()
        query = list(cur.fetchall())   
        for itens in query:
            l.append(str(itens).replace("'", "").replace("(", "").replace(")", "").replace(",", ""))

        cur.close()

    return l

# --------------------------------------------------------------------------------------------------------------------

def showSqlServerVersions():

    v='%2000%'

    df = pd.DataFrame({'CONNECT_STRING': [],'VERSAO': []})

    with inventario() as cur:     
        
        _sql = f"select distinct CONNECT_STRING,case when versao like '{v}'  THEN 'SQL2000'    ELSE 'SQL2008' END  from  DATABASES_MSSQL where TIPO = 'PRD' and EM_MANUTENCAO = 'N' and SITE = 'MKZ' and host='NTSPO006'"
        cur.execute(_sql)
    
        for itens in cur:
           aux =  str(itens[0]).replace("'", "").replace("(", "").replace(")", "").replace(",", "").replace('\\\\','\\')
           df = df.append({'CONNECT_STRING': str(aux),'VERSAO': str(itens[1]) }, ignore_index=True)   
        
    return df



def searchSQLogins(_server,_busca,_versao):
   
        if '2000' in _versao:           
                try: 
                    with bancoSQL(str(_server),'master') as cur:         
                
                        cur.execute(f"select name from syslogins where name = '{_busca}'")                        
                        _usr = cur.fetchone()
                        if _usr == None:
                                   return False
                                    
                except Exception as e:
                       print(e)
        else:                     
                    try: 
                        with bancoSQL(str(_server),'master') as cur:         
                        
                                cur.execute(f"select name from sys.syslogins where name = '{_busca}'")                        
                                _usr = cur.fetchone()
                                if _usr == None:
                                    return False

                    except Exception as e:
                            print(e)
                            #_log.error(e)

        return  True 
 
 
def searchSQLUser(_server,_busca,_bd):

                try:
                    with bancoSQL(str(_server),_bd) as cur:         

                        cur.execute(f"select name from sysusers where name = '{_busca}'")                        
                        _usr = cur.fetchone()
                        if _usr == None:
                                    return False                                
                 
                except Exception as e:
                    print(e)     

                return  True 


def listAllSqlDatabase(_server):

                df = pd.DataFrame({'DATABASES': [],'SERVIDOR': []})
                try: 
                    with bancoSQL(_server,'master') as cur:         
                
                        cur.execute("select name from sysdatabases")
                        query = list(cur.fetchall())
                    
                        for rows in query:
                            df =  df.append({'DATABASES': str(rows[0]),'SERVIDOR': str(_server)}, ignore_index=True)

                except Exception as e:
                       print(e)
                return df

def dropSqlUser(_server,_busca,_db):

             try:
                    connection = sqlConn(_server,_db) 
                    connection.autocommit(True)
                    cursor = connection.cursor()
                    sql = f"exec dbo.sp_revokedbaccess [{_busca}];"
                    cursor.execute(sql)
                        
             except Exception as e:
                       print(e)

             connection.commit()
             connection.close()
             print(f'Usuario {_busca} foi apagado')

def dropSqlogin(_server,_busca):    
             try:
                 
                    connection2 = sqlConn(_server,'master') 
                    connection2.autocommit(True)
                    cursorL2 = connection2.cursor()
                    sql=f"exec dbo.sp_droplogin    [{_busca}];"
                    cursorL2.execute(sql)

             except Exception as e:  
                       pass                     
                       

             connection2.commit()
             connection2.close()
             print(f'Login {_busca} foi apagado')




# --------------------------------------------------------------------------------------------------------------------


def showExistUser(_server,_db,_login,_version):


    _user = "sql_monit"
    _password = "Db@m0n!t"
    _server = _server.replace("'", "").replace("(", "").replace(")", "").replace(",", "").replace('\\\\','\\')

    sql1 = "EXEC sp_dropuser'"+_login+"'"
    sql2 = "Revoke Connect from " + _login

    loginsql = "SELECT name FROM SYSUSERS WHERE NAME ='"+_login+"'"
    loginAD = "SELECT top 1 name FROM SYSUSERS WHERE NAME ='"+'embratel\\' + _login+"'"

    retorno = ""


#-- Conecta no servidor / base de dados passados como parametro 

    try:
        connectionL2 = pymssql.connect(_server, _user, _password, _db)
        cursorL2 = connectionL2.cursor()
        connectionL2.autocommit(True) # Seta a conexao como automit para poder execupar a procedure sp_dropuser
    except pymssql.Error as ex:
        sqlstate = ex.args[0]
        print(sqlstate)
        print ('---------------------------------')
        print(_server,_db)
        print ('---------------------------------')

#-- Inicio da busca do usuario -------------------------------------------------------------------------

# Busca o login puro --------------------------------------
    try:
        cursorL2.execute(loginsql)
        data = cursorL2.fetchone()
    except pymssql.Error as ex:
        sqlstate = ex.args[0]
        print(sqlstate)
        print ('---------------------------------')
        print ('Erro na busca do login puro',_server,_db)
        print ('---------------------------------')

    if data is None:
        try:
            cursorL2.execute(loginAD)
            data = cursorL2.fetchone()
        except pymssql.Error as ex:
            sqlstate = ex.args[0]
            print(sqlstate)
            print ('---------------------------------')
            print('Erro na busca do login com dom. EMBRATEL',_server,_db)
            print ('---------------------------------')



# -------------------- Fim da busca dos usuarios ----------------------------------------------------------		 

    if data is None:
        print('---------------------------------')
        print('Sai pois nao encontrou o usuario',_server,_db)
        print('---------------------------------')
        cursorL2.close()
        connectionL2.close()
        retorno = '(0 row(s) affected)'
    else:
        if _version == 'SQL Server 2000':
            print('usuario e do sql 2000 para apagar')        
            sql1 = "EXEC sp_dropuser'"+_login+"'"
            try:
                cursorL2.execute(sql1)
                cursorL2.close()
                connectionL2.close()
                retorno = 'User '+ _login +' has been dropped from current '+_db    
 
            except pymssql.Error as ex:
                sqlstate = ex.args[0]
                print(sqlstate)
                print ('---------------------------------')
                print('Error ao apagar user SQL 2000',_server,_db)
                print ('---------------------------------')
        else:   
            try:
                 print('usuario e 2008 ou superior')
                 sql2 = "Revoke Connect from " + _login
                 cursorL2.execute(sql2)
                 cursorL2.close()
                 connectionL2.close()
                 retorno = 'Comando(s) concluido(s) com exito.'
            except pymssql.Error as ex:
                     sqlstate = ex.args[0]
                     print(sqlstate)
                     print ('---------------------------------')
                     print('usuario e 2008 ou superior',_server,_db)
                     print ('---------------------------------')

 
    return retorno