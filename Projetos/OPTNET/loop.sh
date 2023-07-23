#!/bin/bash

base=$1



check_directory () {


base=$1
data=$(date +%Y%m%d)
d='/tools/oracle/suporte/scripts/mssql/scripts/'



DIR=$d$base$data

#if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
#  rm -r  ${DIR}
#fi


echo "${base}${data}.zip"

if [ -f "${base}${data}.zip" ]; then
  # Take action if $DIR exists. #
  rm   ${diretorio}
fi

}


gera_comando () {


base=$1

dir='/tools/oracle/suporte/scripts/mssql/scripts/'

data=$(date +%Y%m%d)

final=$base

#Caminho final completo onde sera gerado os exports
diretorio=$dir$final$data


if [ -d "$diretorio" ]; then
  # Take action if $DIR exists. #
  rm -r  ${diretorio}
fi



if [ -f "${base}${data}.zip" ]; then
  # Take action if $DIR exists. #
  rm   "${dir}${final}${data}.zip"
fi




mkdir $dir$base$data




for db in $(/opt/mssql-tools/bin/sqlcmd -S5.8.9.137 -Uuser_dba  -Pcanad@001 -d $final  -Q "SET NOCOUNT ON; SELECT UPPER(NAME) AS TABELA FROM SYSOBJECTS WHERE XTYPE = 'U'" -h-1); do


    echo "/opt/mssql-tools/bin/sqlcmd -S5.8.9.137 -Uuser_dba  -Pcanad@001 -d${final} " " -Q'SET NOCOUNT ON;select * from  ${db} '  -f o:1252 -o ${diretorio}/${db}.txt -s""'|'"" -W"  >> $diretorio/completo.sh

# /tools/oracle/suporte/scripts/mssql/scripts/completo.sh

done

}


executa_bcp () {

source ${diretorio}/completo.sh

}


lista_txt (){

for sql_file in `ls ${diretorio} | grep .txt`;
do

       sed -i '2d'  ${diretorio}/$sql_file

done

}

zipa_sql (){

zip -9 -r /tools/oracle/suporte/scripts/mssql/scripts/$final$data ${diretorio} -i \*.txt
# zip -r xxx.zip /tools/oracle/suporte/scripts/mssql/scripts/optnet_V4_arac_dat20230223/*.txt
}


zipa_sql2 (){


dir='/tools/oracle/suporte/scripts/mssql/scripts/'
data=$(date +%Y%m%d)
final=$base
diretorio=$dir$final$data


# zip -r xxx.zip /tools/oracle/suporte/scripts/mssql/scripts/optnet_V4_arac_dat20230223/*.txt
#zip  /tools/oracle/suporte/scripts/mssql/scripts/$final ${diretorio} -i \*.txt


 zip -r  ${final}${data}.zip /tools/oracle/suporte/scripts/mssql/scripts/$final$data/*.txt

}



teste () {


base=$1

string=$1
prefix="?"
suffix="?"

prefix_removed_string=${string}
suffix_removed_String=${prefix_removed_string/%$suffix}

final=$suffix_removed_String


dir='/tools/oracle/suporte/scripts/mssql/scripts/'

echo 'Criando diretorio : ' $final

mkdir $dir$final


}

#teste $1

gera_comando $1

executa_bcp

lista_txt

zipa_sql

#zipa_sql2

#check_directory $1
