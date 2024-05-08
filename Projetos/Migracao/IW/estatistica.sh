
for table_name in `/usr/local/mysql/bin/mysql --defaults-file=/iw/conf.d/iw/brux0395.cnf -e "select concat(database_name,'.',table_name) as table_name from mysql.innodb_table_stats  where last_update<=now() - INTERVAL 90 DAY and table_name not like '%#%' order by last_update"`; do
        /usr/local/mysql/bin/mysql --defaults-file=/iw/conf.d/iw/brux0395.cnf -e "ANALYZE TABLE $table_name";
done

for table_name in a; do
        `/usr/local/mysql/bin/mysql --defaults-file=/iw/conf.d/iw/brux0395.cnf -e "CALL mysql.CheckAndUpdateStatsForAllTables3('iwprd_hem')" >/iw/scripts/$a`;

done

for table_name in `/usr/local/mysql/bin/mysql --defaults-file=/iw/conf.d/iw/brux0395.cnf -e "CALL mysql.CheckAndUpdateStatsForAllTables3('iwprd_hem')"`; do
        
        echo $table_name
done


