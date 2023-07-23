#!/bin/bash

#################################################################
#                                                               #
#  Daniel Pimenta -                                             #
#                                                               #
#  Implementado limpeza automatica dos logs  de backup          #
#                                                               #
#################################################################               

DIR_LOG=/mysql/log/                     # Diretorio onde o log é gravado
DIR_COMPRIMIDOS=/mysql/log/bkpLogHist   # Diretorio de historico dos logs


find ${DIR_LOG}mysqlMEB_backup_err-*.log -mtime +1 -exec mv "{}" ${DIR_COMPRIMIDOS} \;

find ${DIR_LOG}mysqlMEB_backup_out-*.log -mtime +1 -exec mv "{}" ${DIR_COMPRIMIDOS} \;