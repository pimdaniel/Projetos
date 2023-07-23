#!/bin/bash

#################################################################
#                                                               #
#  Daniel Pimenta -                                             #
#                                                               #
#  Implementado limpeza automatica dos logs e compressão diaria #
#                                                               #
#################################################################


DIR_LOG=/mysql/auditlog/
DIR_COMPRIMIDOS=/mysql/auditlog/comprimidos
DATA=`date +%Y-%m-%d`

cat ${DIR_LOG}clstsgslx4262-audit.log > ${DIR_COMPRIMIDOS}/${DATA}_LOG_AUDIT.TXT
find ${DIR_LOG}*.log -mtime +1 -exec rm -rf {} \;
find ${DIR_COMPRIMIDOS}/*.gz -mtime +30 -exec rm -rf {} \;
gzip ${DIR_COMPRIMIDOS}/${DATA}_LOG_AUDIT.TXT
