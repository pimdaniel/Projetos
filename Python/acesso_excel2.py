import openpyxl as openpyxl
import xlsxwriter
from DAL import mysqlConn
import pandas as pd


# -----------------------------------------------------------------------------------------------------------------------------
path = r"C:\Claro\Desenvolvimento\XXXXXXX.xlsx"
# Cria um excel a partir de uma query  em um database

#Cria um DataFrame
df = pd.DataFrame({'ususarios': [],'host': []})

#cria conexao com o banco
conn =mysqlConn()
cur = conn.cursor()

#Query a ser executada
sql="select user,host from mysql.user;"

#Abre um cursor para a query
cur.execute(sql)

for itens in cur: 
    #print(str(itens[0]))
    df = df.append({'ususarios': str(itens[0]),'host': str(itens[1]) }, ignore_index=True)   
conn.close()

df.to_excel(path,sheet_name='mysqlUsers',index=False)
# -----------------------------------------------------------------------------------------------------------------------------