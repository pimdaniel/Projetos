
  CREATE TABLE "DBMON"."DATABASES_MSSQL" 
   (	
    
    "SITE" VARCHAR2(3 BYTE), 
	"HOST" VARCHAR2(60 BYTE), 
	"DB_NAME" VARCHAR2(100 BYTE), 
	"VERSAO" VARCHAR2(80 BYTE), 
	"RELEASE" VARCHAR2(17 BYTE), 
	"TIPO" VARCHAR2(3 BYTE), 
	"ADMINISTRACAO" VARCHAR2(3 BYTE), 
	"24/7" VARCHAR2(1 BYTE), 
	"NO_AR" VARCHAR2(1 BYTE), 
	"EM_MANUTENCAO" VARCHAR2(1 BYTE), 
	"LEGADO" VARCHAR2(1 BYTE), 
	"SCRIPT_PATH" VARCHAR2(2000 BYTE), 
	"SISTEMA" VARCHAR2(90 BYTE), 
	"PRODUCAO" VARCHAR2(200 BYTE), 
	"ORIGEM" VARCHAR2(3 BYTE), 
	"IP_ADDRESS" VARCHAR2(17 BYTE), 
	"CREATION_DATE" DATE, 
	"CRITICO" VARCHAR2(1 BYTE), 
	"PLATFORM_ID" NUMBER, 
	"PLATFORM_NAME" VARCHAR2(101 BYTE), 
	"LGPD" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"SOX" VARCHAR2(1 BYTE), 
	"CONNECT_STRING" VARCHAR2(100 BYTE), 
	"PORTA" VARCHAR2(6 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  
 

## Script cadastrar no inventario SQLServer

declare @server varchar(80) , @ip varchar(20) ,@data varchar(10) , @connect_string varchar(50)

set @server = 'CLNEWCLAW7422'
set @ip = '10.88.132.111'
set @connect_string = '10.88.132.111'
set @data =  convert(varchar(10),getdate(),120)
 
#Inferior ao Sql 2008
select 'INSERT INTO  DATABASES_MSSQL values (''MKZ'','+''''+cast(@server as varchar)+''''+','+''''+ cast(name as varchar)+''''+','+'''SQL Server 2008 R2'',''10.50.1600.1'',''PRD'',''ORA'',''S'',''S'',''N'',''N'','''',''  '',''  '',''EBT'''+','+''''+cast(@ip as varchar)+''''+','+'sysdate'+ ',''N'',''0'','' '',''N'','' '','''+cast(@connect_string as varchar)+''','' '');' from sys.sysdatabases where name not in ('tempdb')

# Superior a Sql2012
select CONCAT('INSERT INTO  DATABASES_MSSQL values (''MKZ''',',','''',@server,'''',',','''',name,'''',',''SQL Server 2019'',''15.0.2000.5'',''PRD'',''ORA'',''S'',''S'',''N'',''N'','''',''  '',''  '',''EBT''', ',','''',@ip,'''',',sysdate,','''N'',0,'''',''N'','''',', '''',@connect_string,'''' ,','''');' ) from sys.sysdatabases where name not in ('tempdb')
 




 server=10.2.20.33
login=dbmon
pwd=monitoracaocoti20
