import pymssql
import cx_Oracle
import mysql.connector

import sys
sys.path.append("../")
from DAL  import  crypDAL as cr


class bancoSQL:  
  def __init__(self,servidor,banco):
    self.servidor =servidor   
    self.banco=banco
    self.pwd =  cr.getDBpwd()    

  def __enter__(self):   
    self.conn = pymssql.connect(self.servidor,'dbmon',self.pwd,self.banco)
    return self.conn.cursor()
   
  def __exit__(self,a,b,c):
    self.conn.close()

class bancoMysql:  

  def __init__(self,servidor,banco):
    self.servidor =servidor   
    self.banco=banco
    self.user='dbmon'
    self.password = cr.getDBpwd()

  def __enter__(self):   
    self.conn =  mysql.connector.connect(host=self.servidor,database=self.banco,user=self.user,password=self.password,port=3306)  

    return self.conn.cursor()
   
  def __exit__(self,a,s,c):
    self.conn.close()
      
class inventario:  
  def __init__(self):
   self._server = "P00INV"
   self._user = "dbmon"
   self._password = cr.getDBpwd()  
   self._tns =self._user+"/"+self._password+"@"+self._server

  def __enter__(self):   
    self.conn =cx_Oracle.connect(self._tns)
    return self.conn.cursor()
   
  def __exit__(self,a,s,d):
    self.conn.close()



def sqlConn(_host,_db):
  _server=_host
  _user = "dbmon"
  _password = cr.getDBpwd()
  _db = _db
  connection = pymssql.connect(_server, _user, _password, _db)

  return connection


def invConn():

    _server = "P00INV"
    _user = "dbmon"
    _password = cr.getDBpwd()   
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
    _password = cr.getDBpwd() 

    connection = pymssql.connect(_server, _user, _password, _db)
   

    return connection

 


def sqlConnDbmon(_host,_database):
  _server=_host
  _user = "dbmon"
  _password = cr.getDBpwd()
  _db = "master"
  connection = pymssql.connect(_server, _user, _password, _db)

  return connection


def mysqlConn():
 
  _host="10.243.172.57"
  _user="dbmon"
  _password = cr.getDBpwd()
  connection = mysql.connector.connect(host="10.10.254.68",database="mysql",user="dbaadmin",password="Inicio@5",port=3306)
  # mysql.connector.connect(host=_host,user=_user,password=_password)

  return  connection


def escreve():
 _a="dd"
 return  _a



