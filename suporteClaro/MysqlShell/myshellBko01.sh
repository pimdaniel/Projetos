#!/bin/bash
  
  # Pega data
  NOW=$(date +%Y%m%d%H%M)
  #BACKUP_HOME=/mysql/backup/$1/$DATE
  BACKUP_HOME=/mysql/backup/clstsgslx4566/Master/$NOW
  PATH=$PATH:/mysql/backup/mysql-shell-commercial-8.0.33-linux-glibc2.12-x86-64bit/bin
  export PATH
 
 
  mkdir -p $BACKUP_HOME
 
  
  #PATHCONF="/mysql/conf.d"
  #MYCNF=conn
 
  ##### Altera innodb_max_dirty_pages_pct para 0
 
  #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "set global innodb_max_dirty_pages_pct=0";
  #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "FLUSH PRIVILEGES";
 
 
  # mysqlsh -umysqlbackup -pSenha#01 -h127.0.0.1 -- util dump-instance $BACKUP_HOME --excludeSchemas=test --threads=50 --dryRun=false --consistent=false --ocimds=false --showP    rogress=true
 
  mysqlsh --login-path=shellbackup  -- util dump-instance $BACKUP_HOME --excludeSchemas=test --threads=50 --dryRun=false --consistent=false --ocimds=false --showProgress=true
 
  # characterSet: 'utf8mb3'
 
 
  ##### Altera innodb_max_dirty_pages_pct para 75
   #/usr/local/mysql/bin/mysql --defaults-file=$PATHCONF/$MYCNF.cnf -e "set global innodb_max_dirty_pages_pct=75";
 
  # Limpa últimos backups
  find /mysql/backup/clstsgslx4566/Master/ -maxdepth 1 -type d -name "202*" -mtime +4 -print0 | xargs -0 rm -rf
