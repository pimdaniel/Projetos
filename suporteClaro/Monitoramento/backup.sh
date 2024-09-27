

#Saidas

    #SUCCESS
    #FAILURE




mysqlCheckBackup(){

MSG=$(`mysql -udbmon -pmonitoracaocoti20 -hbrux0395 mysql -BNe"select exit_state from mysql.backup_history where DATEDIFF(now(),start_time) = 0;"`)

}


select start_time, exit_state,last_error from mysql.backup_history order by start_time desc limit 1;


`mysql -udbmon -pmonitoracaocoti20 -h$CONN mysql -BNe"select exit_state from mysql.backup_history where DATEDIFF(now(),start_time) = 0;"`

`mysql -udbmon -pmonitoracaocoti20 -hbrux0395 mysql -BNe"select exit_state from mysql.backup_history where DATEDIFF(now(),start_time) = 0;"`