#!/bin/bash

# Variaveis
USER=backup;
PASS=B@ck11p!;
MYSQLBACKUP_DIR=/app/mysql/app.d/meb-4.0.3-el7-x86-64bit/bin
BACKUP_DIR=/backup/mysql;
#EXPURGO=`ls -1 $BACKUP_DIR/FULL |awk -F "_" '{print $1}'`
LOG=$BACKUP_DIR/MYSQLBACKUP_cbl2cm84186_COMPRESS_FULL_IMAGE_`date +"%Y%m%d_%H%M"`.log

# Variaveis de Ambiente
PATH="${PATH}:/usr/bin:/usr/sbin:/usr/local/bin";

# Functions

alert()
{
set -x
echo "Favor verificar log ${LOG}" |mailx -s "Erros no log ao executar o MySQL Backup - `hostname` - `date '+%b %d %H:%M'` " daniel.pimenta@claro.com.br
}

Backup()
{
# Image Backup FULL with Compress
${MYSQLBACKUP_DIR}/mysqlbackup --socket=/var/lib/mysql/mysql.sock --user=${USER} --password="${PASS}" --compress --no-locking --backup-image=cbl2cm84186_IMAGE_BACKUP_`date +"%Y%m%d_%H%M"`.mbi --with-timestamp --backup-dir=${BACKUP_DIR}/FULL backup-to-image 2>> ${LOG} ;
}

Expurgo()
{
for i in `ls $BACKUP_DIR/FULL |cut -c 1-10`; do
if [[ $i == `date +"%Y-%m-%d"` ]]; then
echo "Backup Diario $i" >> ${LOG}
else
echo "Removendo o diretorio ${BACKUP_DIR}/FULL_148/${i}" >> ${LOG}
rm -rf ${BACKUP_DIR}/FULL_148/$i*;
fi;
done;
}

Check()
{
BACKUPSTAT=`/usr/bin/mysql -u ${USER} -p${PASS} -S /var/lib/mysql/mysql.sock -sN --execute='select exit_state from mysql.backup_history where date_format(end_time,"%d/%m/%Y")=DATE_FORMAT(NOW(),"%d/%m/%Y") order by backup_id desc limit 1' 2> /dev/null`

if [[ ${BACKUPSTAT} == "SUCCESS" ]]; then
   echo "Backup realizado com sucesso!"  >> ${LOG}
else
   echo "Erros no Backup MySQL" >> ${LOG}
   alert ${LOG};
exit 1
fi
}

# Main Script
echo "1. Iniciando o Backup" >> ${LOG}
Backup;

#echo "2. Expurgo dos diretorios antigos" >> ${LOG}
#Expurgo;

echo "3. Verificar erros" >> ${LOG}
Check;
