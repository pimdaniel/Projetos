#!/bin/bash
  
   # Configuracao
   host="localhost"                         # nome do host
   user="dbmon"                             # nome de login
   pass="monitoracaocoti20"                         # senha
   nb="3"                                   # RETENCAO - numero maximo de arquivos mantidos de backup
   base_dir="/mysql/backup/export"          # Local do backup
  
  # bancos que nao vao entrar no backup
  be="information_schema|test"
 
 
  # Variaveis estaticas
  server=$(uname -a|awk '{ print $2 }')    # nome do servidor
  bk="$base_dir"                           # diretorio de destino dos dumps
  bl="/mysql/backup/export/log"            # diretorio de destino dos logs
  nw=$(date +%Y%m%d.%H%M%S)                # variavel de hora
  ln="$bl/mysql.dumps.$nw.log"             # formato do arquivo de log
  lnbkpfull="$bl/mysql.dump.full.$nw.log"  # formato do arquivo de log do backup full
 
 
  # Definicao de comandos
  _mysqldump=$(which mysqldump)
  _mail=$(which mail)
  _mysql=$(which mysql)
  _echo=$(which echo)
  _awk=$(which awk)
  _sed=$(which sed)
  _grep=$(which grep)
  _cp=$(which cp)
  _bzip2=$(which bzip2)
 
 
   for db in $($_mysql -u$user -p$pass -B -s -e 'show databases;'| egrep -v $be); do
                  $_echo -e "\nefetuando backup do banco: [ $db ]" | tee -a $ln
                  # fazendo o dump dos bancos detectados
                  BACKUP="$bk/mysql.$db.$(date +%Y%m%d.%H%M%S).dump"
                 if $_mysqldump --skip-lock-tables  --user=$user --password=$pass $db $1  -c > $BACKUP
                          then
                          $_echo "arquivo com dump do banco [ $db ] gerado em : [ $BACKUP  ]:" | tee -a $ln
                  else
                                  $_echo "Erro"
                  fi
   done
 
 
  # BACKUPFULL="$bk/mysql.full.$(date +%Y%m%d.%H%M%S).dump.bz2"
 
  #      $_echo -e "\nInicio de execucao do backup full ... $(date +%Y%m%d.%H%M%S)\n" | tee -a $ln
  #      $_mysqldump --user=$user --password=$pass  --events --single-transaction --flush-logs --hex-blob -A --log-error=$lnbkpfull|bzip2 -c > $BACKUPFULL
  #      $_echo -e "\nFim de execucao do backup full ... $(date +%Y%m%d.%H%M%S)\n" | tee -a $ln
