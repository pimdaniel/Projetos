#!/bin/bash
  5
  6 # Pega data
  7 NOW=$(date +%Y%m%d%H%M)
  8 #BACKUP_HOME=/mysql/backup/$1/$DATE
  9 BACKUP_HOME=/mysql/backup/clstsgslx4566/Master/$NOW
 10 PATH=$PATH:/mysql/backup/mysql-shell-commercial-8.0.33-linux-glibc2.12-x86-64bit/bin
 11 export PATH
 12
 13
 14 mkdir -p $BACKUP_HOME
 15
 16
 17 #PATHCONF="/mysql/conf.d"
 18 #MYCNF=conn
 19
 20 ##### Altera innodb_max_dirty_pages_pct para 0
 21
 22 #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "set global innodb_max_dirty_pages_pct=0";
 23 #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "FLUSH PRIVILEGES";
 24
 25
 26 mysqlsh -umysqlbackup -pSenha#01 -h127.0.0.1 -- util dump-instance $BACKUP_HOME --excludeSchemas=test --threads=50 --dryRun=false --consistent=false --ocimds=false --showProgress=true
 27
 28 # characterSet: 'utf8mb3'
 29
 30
 31 ##### Altera innodb_max_dirty_pages_pct para 75
 32  #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "set global innodb_max_dirty_pages_pct=75";
 33
 34 # Limpa últimos backups
 35 find /mysql/backup/clstsgslx4566/Master/ -maxdepth 1 -type d -name "202*" -mtime +4 -print0 | xargs -0 rm -rf
