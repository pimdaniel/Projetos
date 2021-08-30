import numpy as np  
import matplotlib.pyplot as plt
import pandas as pd
import sys 
sys.path.append("../")
from DAL import labConn2
from LOG import logs_APP as log
import plotly.express as  px



# Com o pandas monsta um dataFrame com os dados do Excel
_arq = pd.read_excel(r"C:\Claro\Desenvolvimento\Python\server.xlsx")

 #configurando o los dos erros de banco de dados
_log = log.logDatabase()
 
#Filtra linha e coluna
#print(_arq.loc[:,["banco"]])

#-------------------- Grafico de linha ----------------------------

#plt.plot(_arq['total'])
#plt.show()
#plt.savefig('books_read.png')
#------------------------------------------------


#----------------- Grafico de Barra -------------------------------

#plt.hist(_arq["total"],bins=20)
#plt.show()
#------------------------------------------------

 
#conectando no banco 
connection = labConn2() 

cursorL2 = connection.cursor()
sql = "dbo.testepython"
 
cursorL2.callproc(sql)

df2 = pd.DataFrame({'tec': [],'origem': [],'total': []})

for itens in cursorL2: 
    #print(str(itens[0]) )
    df2 = df2.append({'tec': str(itens[0]+':'+str(itens[2])+' hosts'),'origem': str(itens[1]),'total': str(itens[2])   }, ignore_index=True)
            

fig=px.sunburst(df2,path=['origem','tec'],values='total',height=900 )

fig.update_traces(textfont_color='white',
                  textfont_size=14,
                  hovertemplate='<b>%{label}:<b> %{value:.2f}%')

fig.show()

#-------------  Grafico de Pizza ---------------------------
'''
plt.pie(df2["total"],labels=df2["TEC"],autopct="%1.0f%%")
plt.title="Percentual de servidor por total de databases"
plt.show()
'''
#------------------------------------------------
