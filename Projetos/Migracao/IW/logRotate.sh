

# Diretorio de cada arquivo que sera feito o ROTATE
   LOG_DIR=/mysql/log.d
   LOG_DIR_ROT=/mysql/log.d/logRotate
  
   #Nome dos arquivos de ROTATE
   ERR=log_error.log
   SLOW=slow.log
 
 
   DATA=`date +"%Y%m%d"`
 
 
  mv $LOG_DIR/$SLOW $LOG_DIR_ROT/$SLOW-$DATA.log.old
  gzip  $LOG_DIR_ROT/$SLOW-$DATA.log.old
 
  mv $LOG_DIR/$ERR $LOG_DIR_ROT/$ERR-$DATA.log.old
  gzip  $LOG_DIR_ROT/$ERR-$DATA.log.old
 
 
  /mysql/app.d/mysql/bin/mysqladmin --login-path=root --socket=/mysql/mysql.sock flush-logs


 