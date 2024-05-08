

select concat(database_name,'.',table_name) as table_name 
from mysql.innodb_table_stats 
 where last_update<=now() - INTERVAL 90 DAY and table_name not like '%#%'


 SELECT  *
        FROM information_schema.statistics
        WHERE table_schema = dbName
          AND table_name = tableName
          AND non_unique = 1;



select concat(TABLE_SCHEMA,'.',table_name) as table_name 
from mysql.innodb_table_stats;


SELECT distinct concat(TABLE_SCHEMA,'.',table_name) as table_name 
FROM information_schema.statistics
where non_unique = 1 
and concat(TABLE_SCHEMA,'.',table_name) not in ( select distinct concat(TABLE_SCHEMA,'.',table_name) as table_name 
from mysql.innodb_table_stats );
        
        
        
        SELECT  * 
FROM information_schema.statistics 
where non_unique = 1  and 


