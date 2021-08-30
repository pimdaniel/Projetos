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