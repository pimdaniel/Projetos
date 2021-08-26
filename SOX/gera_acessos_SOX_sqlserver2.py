import pymssql
from time import gmtime, strftime
import os
import sys 
sys.path.append("../")
from DAL.blk import  showSqlServerSOX
from DAL.crypDAL import getDBpwd
from DAL.CONN import bancoSQL
from LOG.logs_APP import logDatabase

#configurando o los dos erros de banco de dados
_log,_logFile = logDatabase()

user = "dbmon"
password = getDBpwd()
db = "master"

# arq= time.strftime("sqlserver_SOX_"+"%Y%m%d"+".txt")
#arq= time.strftime("/u01/app/oracle/product/12.2.0/dbhome_1/scripts/inventario/python/inv/EMB_todos_usuarios_sqlserver_"+"%d%m%Y")
# arq= "E:/inventario/" + strftime("%Y-%m-%d-%H-%M-%S", gmtime())+".txt"

'''Producao'''
#arq = "E:/inventario/secmonit/EMB_todos_usuarios_sqlserver_" + strftime("%d%m%Y", gmtime())+".txt"

'''DEV'''
arq = r"../EMB_todos_usuarios_sqlserverV3_" + strftime("%d%m%Y", gmtime())+".txt"

lista = showSqlServerSOX()

f = open(arq, "a")

for itens in lista:
    # --------------------------------------------------------------------------------------------------------------------------------------------------------
    # Acessando a lista de bases por servidor

    server = str(itens).replace("'", "").replace("(", "").replace(")", "").replace(",", "").replace('\\\\','\\')
    
    try:
        ''' print(server) # DEBUG '''
        connectionL2 = pymssql.connect(server, user, password, db)
    except pymssql.Error as ex:
        _log.error(ex)

    cursorL2 = connectionL2.cursor()
    
       
    sql = """\
    create table #SOX ( [host_name] varchar(100),instance_name varchar(100) ,username varchar(100),account_status varchar(100),lock_date datetime,expiry_date datetime,created datetime,profil varchar(100) )

    declare @query varchar(2000)
    declare @del varchar(2000)
    DECLARE @name varchar(80)
    DECLARE db_cursor CURSOR FOR

    select name  from sysdatabases   where name not in ('master','tempdb','msdb','model','STAR21','CloneStar21','Easy','WF')

    OPEN db_cursor
    FETCH NEXT FROM db_cursor INTO @name

    WHILE @@FETCH_STATUS = 0
    BEGIN

    set @query = '
    INSERT into #SOX (host_name,instance_name,username,account_status,lock_date,expiry_date,created,profil)
    select
    convert(varchar(100),SERVERPROPERTY(''MachineName'')) as host_name,
    ' +'''' +@name+'''' + '  instance_name ,
    name COLLATE SQL_Latin1_General_CP1_CI_AS as username,
    case when hasdbaccess = 1 then ''Access'' else ''No_Access'' end as account_status,
    null lock_date,
    null expiry_date,
    createdate as created,
    USER_NAME(sm.groupuid) as profil
    from  ' + @name + '..sysusers su inner join ' + @name + '..sysmembers sm on   su.uid=sm.memberuid'

    exec (@query)

    FETCH NEXT FROM db_cursor INTO @name
    END

    CLOSE db_cursor
    DEALLOCATE db_cursor

    delete from #SOX where profil is null
    
select host_name,instance_name,username,account_status,lock_date,expiry_date,created,profil
from (
    select [host_name] COLLATE SQL_Latin1_General_CP1_CI_AS as [host_name] ,
    instance_name  COLLATE SQL_Latin1_General_CP1_CI_AS as instance_name,
    username  COLLATE SQL_Latin1_General_CP1_CI_AS as username,
    account_status ,
    lock_date ,
    expiry_date ,
    created ,
    profil
    from #SOX
    union
    select
    convert(varchar(100),SERVERPROPERTY('MachineName')) as [host_name],
   -- convert(varchar(100),DB_NAME()) COLLATE SQL_Latin1_General_CP1_CI_AS  instance_name ,
    convert(varchar(100),DBNAME) COLLATE SQL_Latin1_General_CP1_CI_AS  instance_name ,
    loginname  COLLATE SQL_Latin1_General_CP1_CI_AS as username,
    case when denylogin = 1 then 'No access' else 'Access' end as account_status,
    null lock_date,
    null expiry_date,
    createdate as created,
    CASE WHEN sysadmin = 1 THEN 'sysadmin'
    WHEN securityadmin=1 THEN 'securityadmin'
    WHEN serveradmin=1 THEN 'serveradmin'
    WHEN setupadmin=1 THEN 'setupadmin'
    WHEN processadmin=1 THEN 'processadmin'
    WHEN diskadmin=1 THEN 'diskadmin'
    WHEN dbcreator=1 THEN 'dbcreator'
    WHEN bulkadmin=1 THEN 'bulkadmin'
    ELSE 'Public' END AS  profil
    from master..syslogins sl
) as X
    where (username not like '#%') and (username not in ('NT AUTHORITY\SYSTEM','NT SERVICE\MSSQLSERVER','NT SERVICE\SQLSERVERAGENT','dbo'))
 """""
    
    cursorL2.execute(sql)

    for rows in cursorL2:
        f.write(
            rows[0] + ";" + rows[1] + ";" + rows[2] + ";" + rows[3] + ";" + str(rows[4]) + ";" + str(
                rows[5]) + ";" + str(rows[6]) + ";" + str(rows[7]) + "\n") 
       
    
    # --------------------------------------------------------------------------------------------------------------------------------------------------------
connectionL2.commit()
connectionL2.close()
f.close()
 


# Arquivo gerado pelo script para realizar o ftp
_arq = "E:/inventario/ftp.ftp"

fp = open(_arq, "w")

fp.write('ftp'+ "\n")
fp.write('open 10.0.198.16' + "\n")
fp.write('SA3AJURIN' + "\n")
fp.write('Ebt@Jur20170606' + "\n")
fp.write('lcd E:\inventario'+ "\n")
fp.write('cd TEMP'+ "\n")
fp.write('mput '+ arq + "\n")
fp.write('yes'+ "\n")
fp.write('quit'+ "\n")
fp.close()

#ftp = "curl -u secmonitbd:bancodados321 -T " + arq +" sftp://10.53.5.12"

#ftp ='ftp -s:E:/inventario/ftp.ftp'

#Executando o FTP
#os.system(ftp)