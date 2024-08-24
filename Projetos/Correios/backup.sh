MYSQL_USER=mysqldumpuser
MYSQL_PASSWD=N3TDB@DUMP
DIRECTORY_HOME=/u01/mysql/backup/DUMP
LOG=${DIRECTORY_HOME}/mysqldumplog_lxtacacsprd01_`date +"%Y%m%d_%H%M%S"`.log

# Funcao
alert()
{
set -x
echo "Favor verificar erros no log ${LOG}" |mailx -s "Erros no log ao executar o MySQL Dump - `hostname` - `date '+%b %d %H:%M:%S'` " supbdbr@claro.com.br,netdbasupport@net.com.br

}

Check_errors()
{
if cat ${LOG} | grep -q "error"; then
        echo "Erros no log executar o MySQL Dump" >> ${LOG}
        alert ${LOG};
#exit 1
else
        echo "Termino do script com sucesso!"  >> ${LOG}
exit 0
fi
}

# Main Script
echo "1. Executando o MySQL dump de todos os bancos do dia `date +"%d/%m/%Y %H:%M"`." >> ${LOG}
##/u01/mysql/bin/mysql/bin/mysqldump --all-databases -u ${MYSQL_USER} -p${MYSQL_PASSWD} -hlocalhost --single-transaction --routines --force --log-error=${LOG} | /bin/gzip >> ${DIRECTORY_HOME}/mysqldump_NET002PRDLNX149_`date +"%Y%m%d_%H%M%S"`.sql.gz
/u01/mysql/bin/mysql/bin/mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWD} -hlocalhost --add-drop-table --routines --events --all-databases --force --log-error=${LOG} | /bin/gzip >> ${DIRECTORY_HOME}/mysqldump_lxtacacsprd01_`date +"%Y%m%d_%H%M%S"`.sql.gz

echo "2. Removendo os arquivos de 1 dias atras!" >> ${LOG}

find ${DIRECTORY_HOME} -name "mysqldump*sql*" -mtime +1 -exec rm -rf {} \; >> ${LOG}
find ${DIRECTORY_HOME} -name "mysqldumplog_*" -mtime +30 -exec rm -rf {} \; >> ${LOG}

echo "3. Verificando erros" >> ${LOG}
Check_errors;

echo "4. Termino do script" >> ${LOG}
