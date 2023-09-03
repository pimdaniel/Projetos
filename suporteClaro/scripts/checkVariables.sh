#!/bin/bash


#Caminho do arquivo de conexao
fileConn="conn.cnf"


memoryVAR(){

variaveis=(innodb_buffer_pool_size innodb_log_file_size query_cache_size max_connections key_buffer_size max_user_connections)


for var in ${variaveis[@]}
do

        # echo $var
        varM=`mysql --defaults-file=$fileConn -N -e"show global variables like '${var}'" | awk '{print $2}'`


          echo $var": " $varM
done
}


dirVAR(){

variaveis=(tmpdir plugin_dir datadir basedir)


for var in ${variaveis[@]}
do

        # echo $var
        varM=`mysql --defaults-file=$fileConn -N -e"show global variables like '${var}'" | awk '{print $2}'`

        echo $var": " $varM
done
}


connVAR(){

variaveis=(Threads_connected Uptime)


for var in ${variaveis[@]}
do

        # echo $var
        varM=`mysql --defaults-file=$fileConn -N -e"SHOW GLOBAL STATUS like '${var}'" | awk '{print $2}'`

        echo $var": " $varM
done
}









echo ""
echo ""
echo "############ Variaveis de Memoria ############"
echo ""

memoryVAR

echo ""
echo ""

echo "############ Principais diretorios ############"
echo ""

dirVAR

echo ""
echo ""

echo "############ Conexoes ############"
echo ""

connVAR

echo "-----------------------------------------------"
echo ""
echo ""
