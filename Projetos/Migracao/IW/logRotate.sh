

# Diretorio de cada arquivo que sera feito o ROTATE
   LOG_DIR=/iw/log.d
   SLOW_DIR=/iw/log.d
  
# Diretorio de destino 
   LOG_DIR_ROT=/iw/log.d/logRotate
  
# Nome dos arquivos de ROTATE
   ERR=mysqld.log
   SLOW=brux0395-slow.log
 
 
   DATA=`date +"%Y%m%d"`
 
# Slow log
  mv $SLOW_DIR/$SLOW $LOG_DIR_ROT/$SLOW-$DATA.log.old
  gzip  $LOG_DIR_ROT/$SLOW-$DATA.log.old
 

# Log de error
  mv $LOG_DIR/$ERR $LOG_DIR_ROT/$ERR-$DATA.log.old
  gzip  $LOG_DIR_ROT/$ERR-$DATA.log.old
 
 
  /usr/local/mysql/bin/mysqladmin --login-path=root  flush-logs

