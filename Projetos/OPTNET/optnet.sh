#!/bin/bash
bd=$1
data=$(date +%Y%m%d)
file=/tools/oracle/suporte/scripts/$bd$data'.zip'


echo $file

# Executa o comando de export remotamente

ssh 10.29.5.214 -l oracle /tools/oracle/suporte/scripts/mssql/scripts/loop.sh ${bd}

#Copia o export zipado do servidor de origem para a brux1279 por enviar por email

scp '10.29.5.214:/tools/oracle/suporte/scripts/mssql/scripts/'$bd$data'.zip'  /tools/oracle/suporte/scripts/mssql/optnet/export


# Envia email zipado com o export de todas as tabelas

echo "OPTNET - Base de dados :  ${bd}" | mail -a /tools/oracle/suporte/scripts/mssql/optnet/export/$bd$data.zip -s "Segue anexo a base de dados: ${bd} ."  daniel.pimenta@claro.com.br,marcelo.storti@claro.com.br
