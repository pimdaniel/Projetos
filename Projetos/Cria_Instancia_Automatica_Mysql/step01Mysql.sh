
### Variaveis para alterar #####################

        #Nome do binario a ser instalado
        TARBIN=mysql-commercial-8.0.33-el7-x86_64

        #Nome do servidor onde sera instalado
        SERVIDOR=cbl2am73567
#################################################


criaDiretorios () {

#Diretorios de configurações

        mkdir -p /mysql/conf.d/mysqld
        mkdir -p /mysql/app.d

#Direotrios de Dados:q

        mkdir -p /mysql/data/databases   #datadir
        mkdir -p /mysql/data/innodb/log
        mkdir -p /mysql/data/tmpdir
        mkdir -p /mysql/data/binario_log

# Diretorios de Backup

        mkdir    /mysql/backup/dump
        mkdir -p /mysql/backup/hotbackup
        mkdir -p /mysql/backup/scripts

sed -e"s/cl42212lx0451/${SERVIDOR}/g" my_default.cnf > my.cnf
cp my.cnf /mysql/conf.d/mysqld

echo ""
echo ""
echo "Fim dacriacao dos diretorios "
echo ""
}


instalaBinario(){


 tar -xzvf $TARBIN.tar.gz -C /mysql/app.d

 cd /mysql/app.d

 ln -s /mysql/app.d/${TARBIN} mysql

 cd /home/mysql

 echo "Binario do Mysql Instalado"

}