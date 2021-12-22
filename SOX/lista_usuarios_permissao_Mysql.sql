

-- Versoes anterioes a 5

select concat(user,'@',host) from mysql.user;

 CONCAT("'",user,"'",'@',"'",host,"'")


##########################################################
#   Lista usuarios e todas as suas permissoes            #
##########################################################

-- Versoes até a 5.7
-- Generico 

SELECT  usuario,PERMISSAO
FROM  (  
SELECT
    CONCAT("`",gtb.Db,"`") AS Bancos,
    CONCAT("`",gtb.Table_name,"`") AS Tabelas,
    gtb.User AS usuario,
    IF(gtb.Host='%','ALL',gtb.Host) AS servidor,
    CONCAT(
        "GRANT ",UPPER(gtb.Table_priv)," ",
        "ON `",gtb.Db,"`.`",gtb.Table_name,"` ",
        "TO '",gtb.User,"'@'",gtb.Host,"';"
    ) AS PERMISSAO
FROM mysql.tables_priv gtb
WHERE gtb.Table_priv!=''

 UNION 


SELECT
    CONCAT("`",gdb.Db,"`") AS Bancos,
    "ALL" AS Tabelas,
    gdb.User AS usuario,
    IF(gdb.Host='%','ALL',gdb.Host) AS servidor,
    CONCAT(
        'GRANT ',
        CONCAT_WS(',',
            IF(gdb.Select_priv='Y','SELECT',NULL),
            IF(gdb.Insert_priv='Y','INSERT',NULL),
            IF(gdb.Update_priv='Y','UPDATE',NULL),
            IF(gdb.Delete_priv='Y','DELETE',NULL),
            IF(gdb.Create_priv='Y','CREATE',NULL),
            IF(gdb.Drop_priv='Y','DROP',NULL),
            IF(gdb.Grant_priv='Y','GRANT',NULL),
            IF(gdb.References_priv='Y','REFERENCES',NULL),
            IF(gdb.Index_priv='Y','INDEX',NULL),
            IF(gdb.Alter_priv='Y','ALTER',NULL),
            IF(gdb.Create_tmp_table_priv='Y','CREATE TEMPORARY TABLES',NULL),
            IF(gdb.Lock_tables_priv='Y','LOCK TABLES',NULL)
        ),
        " ON `",gdb.Db,"`.* TO '",gdb.User,"'@'",gdb.Host,"';"
    ) AS PERMISSAO
FROM mysql.db gdb
WHERE gdb.Db != ''

UNION

SELECT
    "ALL" AS Bancos,
    "ALL" AS Tabelas,
    gus.User AS usuario,
    IF(gus.Host='%','ALL',gus.Host) AS servidor,
    CONCAT(
        "GRANT ",
        IF((gus.Select_priv='N')&(gus.Insert_priv='N')&(gus.Update_priv='N')&(gus.Delete_priv='N')&(gus.Create_priv='N')&(gus.Drop_priv='N')&(gus.Reload_priv='N')&(gus.Shutdown_priv='N')&(gus.Process_priv='N')&(gus.File_priv='N')&(gus.References_priv='N')&(gus.Index_priv='N')&(gus.Alter_priv='N')&(gus.Show_db_priv='N')&(gus.Super_priv='N')&(gus.Create_tmp_table_priv='N')&(gus.Lock_tables_priv='N')&(gus.Execute_priv='N')&(gus.Repl_slave_priv='N')&(gus.Repl_client_priv='N')&(gus.Grant_priv='N'),
            "USAGE",
            IF((gus.Select_priv='Y')&(gus.Insert_priv='Y')&(gus.Update_priv='Y')&(gus.Delete_priv='Y')&(gus.Create_priv='Y')&(gus.Drop_priv='Y')&(gus.Reload_priv='Y')&(gus.Shutdown_priv='Y')&(gus.Process_priv='Y')&(gus.File_priv='Y')&(gus.References_priv='Y')&(gus.Index_priv='Y')&(gus.Alter_priv='Y')&(gus.Show_db_priv='Y')&(gus.Super_priv='Y')&(gus.Create_tmp_table_priv='Y')&(gus.Lock_tables_priv='Y')&(gus.Execute_priv='Y')&(gus.Repl_slave_priv='Y')&(gus.Repl_client_priv='Y')&(gus.Grant_priv='Y'),
                "ALL PRIVILEGES",
                CONCAT_WS(',',
                    IF(gus.Select_priv='Y','SELECT',NULL),
                    IF(gus.Insert_priv='Y','INSERT',NULL),
                    IF(gus.Update_priv='Y','UPDATE',NULL),
                    IF(gus.Delete_priv='Y','DELETE',NULL),
                    IF(gus.Create_priv='Y','CREATE',NULL),
                    IF(gus.Drop_priv='Y','DROP',NULL),
                    IF(gus.Reload_priv='Y','RELOAD',NULL),
                    IF(gus.Shutdown_priv='Y','SHUTDOWN',NULL),
                    IF(gus.Process_priv='Y','PROCESS',NULL),
                    IF(gus.File_priv='Y','FILE',NULL),
                    IF(gus.References_priv='Y','REFERENCES',NULL),
                    IF(gus.Index_priv='Y','INDEX',NULL),
                    IF(gus.Alter_priv='Y','ALTER',NULL),
                    IF(gus.Show_db_priv='Y','SHOW DATABASES',NULL),
                    IF(gus.Super_priv='Y','SUPER',NULL),
                    IF(gus.Create_tmp_table_priv='Y','CREATE TEMPORARY TABLES',NULL),
                    IF(gus.Lock_tables_priv='Y','LOCK TABLES',NULL),
                    IF(gus.Execute_priv='Y','EXECUTE',NULL),
                    IF(gus.Repl_slave_priv='Y','REPLICATION SLAVE',NULL),
                    IF(gus.Repl_client_priv='Y','REPLICATION CLIENT',NULL)
                )
            )
        ),
        " ON *.* TO '",gus.User,"'@'",gus.Host,"' REQUIRE ",
        CASE gus.ssl_type
            WHEN 'ANY' THEN
                "SSL "
            WHEN 'X509' THEN
                "X509 "
            WHEN 'SPECIFIED' THEN
                CONCAT_WS("AND ",
                    IF((LENGTH(gus.ssl_cipher)>0),CONCAT("CIPHER '",CONVERT(gus.ssl_cipher USING utf8),"' "),NULL),
                    IF((LENGTH(gus.x509_issuer)>0),CONCAT("ISSUER '",CONVERT(gus.ssl_cipher USING utf8),"' "),NULL),
                    IF((LENGTH(gus.x509_subject)>0),CONCAT("SUBJECT '",CONVERT(gus.ssl_cipher USING utf8),"' "),NULL)
                )
            ELSE "NONE "
        END,
        "WITH ",
        IF(gus.Grant_priv='Y',"GRANT OPTION ",""),
        "MAX_QUERIES_PER_HOUR ",gus.max_questions," ",
        "MAX_CONNECTIONS_PER_HOUR ",gus.max_connections," ",
        "MAX_UPDATES_PER_HOUR ",gus.max_updates," "
        ";"
    ) AS PERMISSAO
FROM mysql.user gus
) AS X
where usuario = '12018952'
ORDER BY usuario;







##########################################################
#   Lista usuarios \ Tipo de permissao [ COMUM ou ADMIN] #
##########################################################

SELECT DISTINCT USUARIO,servidor,PERMISSAO
FROM  (  
SELECT
    CONCAT("`",gtb.Db,"`") AS Bancos,
    CONCAT("`",gtb.Table_name,"`") AS Tabelas,
    gtb.User AS usuario,
    IF(gtb.Host='%','*',gtb.Host) AS servidor,
   'COMUM' AS PERMISSAO
FROM mysql.tables_priv gtb
WHERE gtb.Table_priv!=''

 UNION 


SELECT
    CONCAT("`",gdb.Db,"`") AS Bancos,
    "ALL" AS Tabelas,
    gdb.User AS usuario,
    IF(gdb.Host='%','*',gdb.Host) AS servidor,
     'COMUM' AS PERMISSAO
FROM mysql.db gdb
WHERE gdb.Db != ''

UNION

SELECT
    "ALL" AS Bancos,
    "ALL" AS Tabelas,
    gus.User AS usuario,
    IF(gus.Host='%','*',gus.Host) AS servidor,
    IF((gus.Select_priv='Y')&(gus.Insert_priv='Y')&(gus.Update_priv='Y')&(gus.Delete_priv='Y')&(gus.Create_priv='Y')&(gus.Drop_priv='Y')&(gus.Reload_priv='Y')&(gus.Shutdown_priv='Y')&(gus.Process_priv='Y')&(gus.File_priv='Y')&
(gus.References_priv='Y')&(gus.Index_priv='Y')&(gus.Alter_priv='Y')&(gus.Show_db_priv='Y')&(gus.Super_priv='Y')&(gus.Create_tmp_table_priv='Y')&(gus.Lock_tables_priv='Y')&(gus.Execute_priv='Y')&(gus.Repl_slave_priv='Y') ,'ADMIN','COMUM') as PERMISSAO
	
	
FROM mysql.user gus
) AS X
ORDER BY PERMISSAO;



#################################################################
#  Listaos donos das views,procedures,funcoes,eventos e rotinas #
#################################################################



select concat(TIPO,";",BANCO,";",DEFINER,";",NOME) as FULL
from (
select 'EVENT' TIPO,EVENT_SCHEMA AS BANCO,DEFINER,EVENT_NAME AS NOME FROM information_schema.EVENTS WHERE DEFINER not in ('root@localhost')
union 
select 'VIEW' as TIPO,TABLE_SCHEMA AS BANCO ,DEFINER,TABLE_NAME as nome from information_schema.VIEWS where DEFINER not in ('root@localhost')
union
select  ROUTINE_TYPE AS TIPO,ROUTINE_SCHEMA AS BANCO,DEFINER,ROUTINE_NAME as nome from information_schema.routines where DEFINER not in ('root@localhost')
union
select 'TRIGGERS' AS TIPO, TRIGGER_SCHEMA AS BANCO,DEFINER,TRIGGER_NAME NOME FROM information_schema.TRIGGERS where DEFINER not in ('root@localhost')
) as X
order by TIPO,BANCO,DEFINER,NOME;

