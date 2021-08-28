
#################################
#  Cursor simples				 #
#################################


DECLARE db_final CURSOR FOR  

select * from #metade

OPEN db_final   
FETCH NEXT FROM db_final INTO @s,@db   

WHILE @@FETCH_STATUS = 0   
BEGIN 


       FETCH NEXT FROM db_final INTO @s,@db   
END   

CLOSE db_final   
DEALLOCATE db_final


 
 SELECT s.name
FROM sys.schemas s
WHERE s.principal_id = USER_ID('T3MBERN');

ALTER AUTHORIZATION ON SCHEMA::db_owner TO dbo;

################################ LOGS  ###################################

 
#################################
#   Query busca Logs MSSQL 2000 #
#################################

select f.name,f.filename
from sysaltfiles f inner join sysdatabases b on f.dbid = b.dbid
where f.filename like '%.LDF%' and b.name not in ('tempdb','master','model','msdb')
  
  

#################################
#   Query busca Logs MSSQL 2008 #
#################################

select f.name,f.filename
from sys.sysaltfiles f inner join sys.sysdatabases b on f.dbid = b.dbid
where f.filename like '%.LDF%' and
b.name  = 'PORTALJU'
--b.name not in ('tempdb','master','model','msdb')




#######################################################################
#  Lista permissao dos ususario de determinados bancos de um servidor #
#######################################################################


-- drop table #SOX

 create table #SOX ( [host_name] varchar(100),instance_name varchar(100) ,username varchar(100),account_status varchar(100),lock_date datetime,expiry_date datetime,created datetime,profil varchar(100) )

declare @query varchar(2000)
declare @del varchar(2000)
DECLARE @name varchar(80)
DECLARE db_cursor CURSOR FOR  

select name    from sysdatabases   where name   in ('GerenciaRequisitos')  -- PARAMETRO COM O NOME DO BANCO DE DADOS QUE SE QUER REALIZAR A BUSCA DOS USUARIOS

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN 

				
set @query = ' INSERT into #SOX (host_name,instance_name,username,account_status,lock_date,expiry_date,created,profil)
			select 
			convert(varchar(100),SERVERPROPERTY(''MachineName'')) as host_name,
			' +''''+ @name +''''+ ' as instance_name,
			-- convert(varchar(100),DB_NAME()) COLLATE SQL_Latin1_General_CP1_CI_AS  instance_name ,
			name COLLATE SQL_Latin1_General_CP1_CI_AS as username,
			case when hasdbaccess = 1 then ''Access'' else ''No_Access'' end as account_status,
			null lock_date,
			null expiry_date,
			createdate as created,
			USER_NAME(sm.groupuid) as profil  
	from  ' + @name + '..sysusers su inner join ' + @name + '..sysmembers sm on   su.uid=sm.memberuid'
	
	--set @del= 'delete from #SOX where profil is null'
	
	-- exec (@del) 
	 exec (@query)
	-- print @query

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor


 
  
		 select [host_name]+';' COLLATE SQL_Latin1_General_CP1_CI_AS as [host_name] ,
				instance_name +';' COLLATE SQL_Latin1_General_CP1_CI_AS as Banco,
				username +';' COLLATE SQL_Latin1_General_CP1_CI_AS as username,
				account_status+';' as [account_status] ,
				convert(varchar,created,120)+';'  as  [data criacao],
				isnull(convert(varchar,lock_date,120),'')+';'    as  bloqueio,
				isnull(convert(varchar,expiry_date,120),'')+';' [data bloqueio] ,
				profil+';' as [profile],
				'EBT' as origem
		 from #SOX
		 where username not in ('dbo')
		 order by instance_name
		 



------------------------------------------------------------------------------------------------- FIM ---------------------------------------------------------------------------------------------------------------------------


##################################################
## TODOS SERVIDORERS TELCO ... rodar na nttlc001 # 
##################################################
 
create table #server (serverName varchar(50) ) 

insert into #server values ('[mvtlc110\sqltelcobi01]')
insert into #server values ('[mvtlc111\sqltelcobi02]')
insert into #server values ('[nttlc103\sqltelcobi03]') 
insert into #server values ('NTTLC001')
insert into #server values ('NTTLC002')
insert into #server values ('NTTLC003')
insert into #server values ('NTTLC004')
insert into #server values ('NTTLC005')
insert into #server values ('NTTLC007')
insert into #server values ('NTTLC008')
insert into #server values ('NTTLC009')
insert into #server values ('NTTLC010')
insert into #server values ('NTTLC011')
insert into #server values ('NTTLC012')
insert into #server values ('NTTLC013')

---------------------------------------------------------------------------- 


create table #query (q varchar(2000))
 

 

declare @query varchar(2000)
declare @Servname varchar(50)
DECLARE @name varchar(80)


DECLARE db_server CURSOR FOR  
select serverName    from #server

OPEN db_server   
FETCH NEXT FROM db_server INTO @Servname  


WHILE @@FETCH_STATUS = 0   
BEGIN 

			set @query = 'insert  into #query (q)
				       select ''select name, '+ '''' + ''''+@Servname + '''' + ''''+ ' as s' +' from ' +@Servname + '.master.dbo.sysdatabases   where name not in (''''master'''',''''tempdb'''',''''msdb'''',''''model'''')'''+ ' as q'
			--print @query
			exec (@query)

 FETCH NEXT FROM db_server INTO @Servname   
END   

CLOSE db_server   
DEALLOCATE db_server

 
------------------------------##############################---------------------------


create table #metade ( s varchar(50) , db varchar(1000)) 


declare @query1 varchar(2000)

declare @q varchar(2000)

DECLARE db_c CURSOR FOR  

select q from #query

OPEN db_c   
FETCH NEXT FROM db_c INTO @q


WHILE @@FETCH_STATUS = 0   
BEGIN 
					insert into #metade (db,s) 
					exec (@q)
			 
		  

 FETCH NEXT FROM db_c INTO  @q  
END   

CLOSE db_c   
DEALLOCATE db_c


--------------------------------------- #################### FINAL ########################  ------------------------------------



create table #SOX ( [host_name] varchar(100),instance_name varchar(100) ,username varchar(100),account_status varchar(100),lock_date datetime,expiry_date datetime,created datetime,profil varchar(100) )
-- truncate table #SOX

declare @query2 varchar(2000),@s varchar(2000),@db  varchar(2000)
  
DECLARE db_final CURSOR FOR  

select * from #metade

OPEN db_final   
FETCH NEXT FROM db_final INTO @s,@db   

WHILE @@FETCH_STATUS = 0   
BEGIN 
				
set @query2 = ' INSERT into #SOX (host_name,instance_name,username,account_status,lock_date,expiry_date,created,profil)
			select 
			' +''''+ @s +''''+ ' as host_name,
			' +''''+ @db  +''''+ ' as instance_name,
			-- convert(varchar(100),DB_NAME()) COLLATE SQL_Latin1_General_CP1_CI_AS  instance_name ,
			name COLLATE SQL_Latin1_General_CP1_CI_AS as username,
			case when hasdbaccess = 1 then ''Access'' else ''No_Access'' end as account_status,
			null lock_date,
			null expiry_date,
			createdate as created,
			USER_NAME(sm.groupuid) as profil  
	from  ' + @s+'.'+@db + '.dbo.sysusers su inner join ' + @s+'.'+@db + '.dbo.sysmembers sm on   su.uid=sm.memberuid'
	
	 
	 
	 exec (@query2)
	--   print @query2

       FETCH NEXT FROM db_final INTO @s,@db   
END   

CLOSE db_final   
DEALLOCATE db_final




 select [host_name]+';' COLLATE SQL_Latin1_General_CP1_CI_AS as [host_name] ,
				instance_name +';' COLLATE SQL_Latin1_General_CP1_CI_AS as Banco,
				username +';' COLLATE SQL_Latin1_General_CP1_CI_AS as username,
				account_status+';' ,
				convert(varchar,created,120)+';'  as  [data criacao],
				isnull(convert(varchar,lock_date,120),'')+';'    as  bloqueio,
				isnull(convert(varchar,expiry_date,120),'')+';' [data bloqueio] ,
				profil+';' as [profile],
				'EBT' as origem
		 from #SOX
		 where username not in ('dbo')
		 order by [host_name]
/*
 drop table #metade
 drop table #SOX
 drop table #query
 drop table #query
 drop table #server
*/







######################################################
####################  SQL Server #####################
######################################################


# Listar Tipo de Recovery dos bancos

select name, databasepropertyex(name, 'Recovery') as RecoveryModel 
from master.dbo.sysdatabases 
order by name,databasepropertyex(name, 'Recovery')



# AGENDAMENTO POR DADOS DO REPORTING SERVICES
if (day(getdate()) = 1) 
   select 'daniel.pimenta' as [TO],'daniel.pimenta@claro.com.br' as[Cc]





######################################################
# 			APAGANDO USUARIOS E LOGINS			  	 #
######################################################


SET NOCOUNT ON

IF OBJECT_ID('tempdb..#result') IS NOT NULL
BEGIN
		truncate table  #result
END
ELSE
BEGIN
		create table #result (id int identity(1,1) ,name varchar(100), base varchar(100))
END

IF OBJECT_ID('tempdb..#comandos') IS NOT NULL
BEGIN
		truncate table  #comandos
END
ELSE
BEGIN
		create table #comandos (id int identity(1,1), comando varchar(1000))

END  


declare @db varchar(100),@user varchar(20),@query_user varchar(200),@query_login varchar(200)
  

SET @user = 'sgcApp' 
 
 
DECLARE db_final CURSOR FOR  

select name as db ,@user as busca  from sys.sysdatabases where name not in ('tempdb')

OPEN db_final   
FETCH NEXT FROM db_final INTO @db,@user  

WHILE @@FETCH_STATUS = 0   
BEGIN 
	
		set @query_user	 = 'insert into #result select name , '+''''+@db+'''' +' as base  from  '+ @db +'..sysusers where name = ' + ''''+@user +''''
 		exec(@query_user) 
 
       FETCH NEXT FROM db_final INTO @db,@user  
END   

CLOSE db_final   
DEALLOCATE db_final
 
 -------------------------------------------------------- 
  
  
  insert into #comandos
  select 'exec '+ convert(varchar,base) + '..sp_revokedbaccess '+ '''' + convert(varchar,name) +'''' as comando  from #result
  
  insert into #comandos	
	select distinct 'drop login ['+ convert(varchar,name) + ']' as comando from #result	 
  
   
 select comando
 from  #comandos  
 order by id asc
   
    