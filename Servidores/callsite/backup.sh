#!/bin/bash

# Configuracao
host="localhost"                     # nome do host
user="monsite"                       # nome de login
pass="monitora"                      # senha
nb="3"                               # RETENCAO - numero maximo de arquivos mantidos de backup
base_dir="/mysql_data/DUMP/DATABASES"          # Local do backup

# bancos que nao vao entrar no backup
be="information_schema|test"


# Variaveis estaticas
server=$(uname -a|awk '{ print $2 }')    # nome do servidor
bk="$base_dir"                           # diretorio de destino dos dumps
bl="/mysql_data/DUMP/bkpLogs"                     # diretorio de destino dos logs
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

        if [ ! -d "$base_dir/$db" ]; then
          mkdir $base_dir/$db
        fi

      for tb in $($_mysql -u$user -p$pass $db -s -e 'show tables;'| egrep -v $be); do

        #  BACKUP="$bk/$db/mysql.$tb.$(date +%Y%m%d.%H%M%S).dump.bz2"
           BACKUP="$bk/$db/$db.$tb.$(date +%Y%m%d.%H%M%S).dump.gz"

          # $_mysqldump -c --user=$user --password=$pass $db $tb  | bzip2 -c > $BACKUP

          $_mysqldump -c --user=$user --password=$pass $db $tb | /bin/gzip > $BACKUP


          if [ $? -eq 0 ]
           then
                $_echo -e "Dump do banco [ $db ] tabela :  [ $tb ] gerado em : [ $BACKUP  ]" | tee -a $ln
          else
                $_echo -e "Erro no Backup do banco [ " $db " ] na tabela: " $tb
         fi
done
done
