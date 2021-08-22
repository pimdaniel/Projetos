
import pymssql
import cx_Oracle
import mysql.connector


class bancoSQL:  

  def __init__(self,servidor,banco):
    self.servidor =servidor   
    self.banco=banco

  def __enter__(self):   
    self.conn = pymssql.connect(self.servidor,'dbmon','monitor',self.banco)
    return self.conn.cursor()
   
  def __exit__(self,a,b,c):
    self.conn.close()

class inventario:  
  def __init__(self):
   self._server = "P00INV"
   self._user = "dbmon"
   self._password="monitor"     
   self._tns =self._user+"/"+self._password+"@"+self._server

  def __enter__(self):   
    self.conn =cx_Oracle.connect(self._tns)
    return self.conn.cursor()
   
  def __exit__(self):
    self.conn.close()



def invConn():

# connection = cx_Oracle.connect('DBMON/DBMON77DBA@p05inv:1521')
# connection = cx_Oracle.connect('dbmon/monitor@P00inv')

    _server = "P00INV"
    _user = "dbmon"
    _password="monitor"     
    _tns = _user+"/"+_password+"@"+_server

    connection = cx_Oracle.connect(_tns)
   
    return connection




def labConn():

    _server = "10.2.20.33"
    _db = "master"
    _user = "da"
    _password="da" 

    connection = pymssql.connect(_server, _user, _password, _db)
   

    return connection


def labConn2():

    _server = "10.2.20.33\sqk2008"
    _db = "SCSEBT2"
    _user = "dbmon"
    _password="monitor" 

    connection = pymssql.connect(_server, _user, _password, _db)
   

    return connection




def sqlConn(_host):
  _server=_host
  _user = "sql_monit"
  _password = "Db@m0n!t"
  _db = "master"
  connection = pymssql.connect(_server, _user, _password, _db)

  return connection


def sqlConnDbmon(_host,_database):
  _server=_host
  _user = "dbmon"
  _password = "monitor"
  _db = "master"
  connection = pymssql.connect(_server, _user, _password, _db)

  return connection



  



def mysqlConn():
 
  _host="10.243.172.57"
  _user="dbmon"
  _password="monitor"
  connection = mysql.connector.connect(host="10.10.254.68",database="mysql",user="dbaadmin",password="Inicio@5",port=3306)
  # mysql.connector.connect(host=_host,user=_user,password=_password)

  return  connection


#mysql.connector.connect("host='10.53.8.20',database='mysql',user='teste1',password='Inicio@1',port=3308")


def escreve():
 _a="dd"
 return  _a



