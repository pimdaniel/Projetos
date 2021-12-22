
''' Tem que estar na pasta Inventario par rodar o scritp'''

import sys
sys.path.append("../")
from DAL.CONN import labConn
from DAL.CONN import sqlConnDbmon
from DAL.blk import showSqlServer,showSqlServerSOX
import pymssql
import pandas as pd


df = pd.DataFrame({'Servidores': []})
df= showSqlServerSOX()


for i in df:
    print(i)

