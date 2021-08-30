import cx_Oracle
import sys 
sys.path.append("../")
from DAL.blk import showExistUser
import time
import os


#chamado = input("Numero do chamado: ")

_chamado = "1234"


# ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
connection = cx_Oracle.connect('dbinv/orainv#04@invprd')
cursor = connection.cursor()
sql = "select distinct CONNECT_STRING,instancia,VERSION_BD from TB_BANCOS where db_sox = 'S' and ambiente = 'PRD' and db_monit = 'S' and SIST_BANCO = 'Sql Server'"
cursor.execute(sql)
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Arquivo gerado pelo script
_arq = "E:/inventario/bloqueados/Bloqueio_SOX_sqlserver_chamado_"+ _chamado +"_"+"%d%m%Y"

# Arquivo de parametro com os Logins
_lista =  'E:/inventario/lista.txt'

exp_soq = time.strftime(_arq )
fp = open(exp_soq, "a")


fp.write('------------------------------------ Claro Brasil -------------------------------------------------------'+ "\n")
fp.write('Bloqueio de usuarios de bancos de dados apartir da lista  do arquivo: '+ exp_soq + "\n")
fp.write('---------------------------------------------------------------------------------------------------------' + "\n")
fp.write("\n")
fp.write("\n")
fp.write("\n")

print("Iniciando bloqueio ...")

for rows in cursor:
 f = open(_lista,'r')
 line = f.readline()
 while line:
    
    user = line
    a = showExistUser(rows[0],rows[1],line.strip('\n'),rows[2])
    line = f.readline()
    fp.write('Servidor: ' + rows[0] + "\n")
    fp.write('Base: ' + rows[1] + "\n")
    fp.write('Usuario: ' + user + "\n")
    fp.write('Status: ' + a + "\n")
    fp.write('#---------------------------------#'+ "\n")
        
f.close()
print("Bloqueio Finalizado ...")
fp.close()
cursor.close()
connection.close()  


