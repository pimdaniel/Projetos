/* 
 drop table #tb
 drop table #temp
 */

declare @ip varchar(40)
Declare @ipLine varchar(200)
Declare @pos int
set nocount on
          set @ip = NULL
          Create table #temp (ipLine varchar(200))
          Insert #temp exec master..xp_cmdshell 'ipconfig'
          select top 1 @ipLine = ipLine
          from #temp
          where upper (ipLine) like '%IP ADDRESS%' or  upper (ipLine) like '%IPV4 ADDRESS%' 
          if (isnull (@ipLine,'***') != '***')
          begin 
                set @pos = CharIndex (':',@ipLine,1);
                set @ip = rtrim(ltrim(substring (@ipLine , 
               @pos + 1 ,
                len (@ipLine) - @pos)))
           end 
drop table #temp
set nocount off  


create table #tb
				 (
				 server_name varchar(100),
				 porta	 varchar(5),
				 [host_name] varchar(100),
				 instance_name varchar(100),
				 connect_string	 varchar(100),
				 Ambiente	varchar(100),
				 user_mont	 varchar(100),
				 senha_monit	 varchar(100),
				 ip	 varchar(30),
				 version_db	 varchar(100),
				 plataforma_name	varchar(100),
				 sist_nome	varchar(100),
				 sist_responsavel	 varchar(100),
				 empresa varchar(100)
				 ) 

 
 declare @a varchar(100)
 select @a = convert(varchar(100),SERVERPROPERTY('InstanceName'))

DECLARE @ver nvarchar(128)
DECLARE @verf nvarchar(128)
SET @ver = CAST(serverproperty('ProductVersion') AS nvarchar)
SET @ver = SUBSTRING(@ver, 1, CHARINDEX('.', @ver) - 1)
 
 
declare @query varchar(2000)
declare @del varchar(2000)
DECLARE @name varchar(80)
DECLARE db_cursor CURSOR FOR  

select [name] from sysdatabases   where [name] not in ('master','tempdb','msdb','model')

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN 

				
IF ( @ver = '7' )
   SELECT 'SQL Server 7'
ELSE IF ( @ver = '8' )
   set @verf =  'SQL Server 2000'
ELSE IF ( @ver = '9' )
   set @verf =  'SQL Server 2005'
ELSE IF ( @ver = '10' )
   set @verf =  'SQL Server 2008 R2'
ELSE IF ( @ver = '11' )
   set @verf =  'SQL Server 2012'
ELSE IF ( @ver = '12' )
   set @verf =  'SQL Server 2014'
ELSE IF ( @ver = '13' )
   set @verf =  'SQL Server 2016'
ELSE
   set @verf =  'Unsupported SQL Server Version'

   
insert into  #tb  (

					server_name ,
					porta	 ,
					[host_name] ,
					instance_name ,
					connect_string	 ,
					Ambiente	,
					user_mont	 ,
					senha_monit,
					ip,
					version_db,
					plataforma_name,
					sist_nome,
					sist_responsavel,
					empresa
				)

 
select
		@@servername as server_name,
		'1433' as porta,
		@@servername [host_name],
		@name as instance_name,						 
		
		 case 
			when @a  is null then convert(varchar(40),SERVERPROPERTY('MachineName'))
			else 
		convert(varchar(40),SERVERPROPERTY('MachineName')) + '\'+convert(varchar(40),isnull(SERVERPROPERTY('InstanceName'),'')) end  as  CONNECT_STRING,

		'PRD'as Ambiente,
		'sa' as USER_MONIT,
		'xxx' as SENHA_MONIT,
		@ip  as IP,
		@verf VERSION_BD,
		RIGHT(@@version, LEN(@@version)- 3 -charindex (' ON ', @@VERSION))  as PLATFORMA_NAME,
		NULL as SIST_NOME	,
		NULL SIST_RESPONSAVEL,
		'EMBRATEL' as EMPRESA
  

       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor


 


DECLARE @SITE VARCHAR(50),@release VARCHAR(50),@tipo VARCHAR(50),@administracao VARCHAR(50),@24 VARCHAR(50),@no_ar VARCHAR(50),@em_manutencao VARCHAR(50),
@legado VARCHAR(50),@script_path VARCHAR(50),@sistema VARCHAR(50),@producao VARCHAR(50),@origem VARCHAR(50),@ip_address VARCHAR(50),@creation_date VARCHAR(50),
@critico VARCHAR(50),@platform_id VARCHAR(50),@platform_name VARCHAR(50),@lgpd VARCHAR(50),@sox VARCHAR(50)


set @SITE='MKZ'
set @release='NULL'
set @tipo='YYY'
set @administracao='SQL'
set @24='S'
set @no_ar='S'
set @em_manutencao='N'
set @legado='N'
set @script_path='NULL'
set @sistema='A preencher'
set @producao='S'
set @origem='EBT'
set @ip_address=''
set @creation_date='NULL'
set @critico='S'
set @platform_id='NULL'
set @platform_name='NULL'
set @lgpd='N'
set @sox='S'

 
select 'INSERT INTO databases_mssql (site,host,db_name,versao,release,tipo,administracao,"24/7",no_ar,em_manutencao,legado,script_path,sistema,producao,origem,ip_address,creation_date,critico,platform_id,platform_name,lgpd,sox,connect_string) VALUES ('+
 ''''+@SITE+''''+','+ '''' + server_name +''''+',' +''''+instance_name+''''+','+''''+version_db+''''+','+  CONVERT(VARCHAR, @release)+','+ ''''+@tipo+''''+','+ ''''+@administracao+''''+','+ ''''+@24+''''+','+ ''''+@no_ar+''''+','+ ''''+@em_manutencao+''''+','+ ''''+@legado+''''+','+ CONVERT(VARCHAR, @script_path)+','
+   ''''+@sistema+''''+','  + '''' + @producao +''''+','+ '''' + @origem +''''+','+ '''' + ip +''''+','+ CONVERT(VARCHAR, @creation_date)+','+ '''' + @critico +''''+','+ CONVERT(VARCHAR, @platform_id)+','+ CONVERT(VARCHAR, @platform_name)+','+ '''' + @lgpd +''''+','+ '''' + @sox +''''+','+ ''''+ connect_string + '''' +');'
from #tb

 