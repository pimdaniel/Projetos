TARBIN=mysql-commercial-8.0.33-el7-x86_64
MYSQL_DIR=/mysql/app.d/$TARBIN
ROOT=$(cat access.txt)



addBashProfile() {

echo 'export PATH=/usr/local/mysql/bin/:$PATH' >> ~/.bash_profile

}

pegaSenha () {

var=$( cat /mysql/log/log_error.log | grep "A temporary" )
y="${var##* }"

}



paraBD() {

echo "Parando serviço do Mysql"

${MYSQL_DIR}/bin/mysqladmin -uroot -p${ROOT} shutdown

sleep 5
echo "Servido do Mysql parado com sucesso ..."
}

alteraSenha() {

pegaSenha

${MYSQL_DIR}/bin/mysql  -uroot -p$y  --connect-expired-password mysql < /home/mysql/altera.sql

echo "Senha de root alterada"


}


iniciaBD(){

${MYSQL_DIR}/support-files/mysql.server start
sleep 10
echo -ne '\n'
echo -ne '\n'
echo "Instalacao finalizada com sucesso."
}

criaInstancia() {

echo "Iniciano servico do Mysql em modo --initialize"

#Passo 1
## Comando para subir o mysql pela primeira vez { obs: --initialize } PEGAR A SENHA DO ROOT NO LOG
${MYSQL_DIR}/bin/mysqld_safe  --defaults-file=/mysql/conf.d/mysqld/my.cnf --initialize --user=mysql  --basedir=${MYSQL_DIR} --datadir=/mysql/data/databases --log-error=/mysql/log/log_error.log  & >> /dev/null
echo -ne '\n'
sleep 10

echo "Subindo servico do Mysql  para alterar a senha do Mysql ...."

#Passo 2
## Iniciar  o mysql para poder alterar a senha do root
${MYSQL_DIR}/bin/mysqld_safe --defaults-file=/mysql/conf.d/mysqld/my.cnf    --user=mysql    --basedir=${MYSQL_DIR} --log-error=/mysql/log/log_error.log --datadir=/mysql/data/databases  & >> /dev/null

echo -ne '\n'
echo "Servico no AR para alterar a senha de root"
echo -ne '\n'

}


#02
criaInstancia
sleep 5
alteraSenha
sleep 5
paraBD
sleep 5
iniciaBD
sleep 5
#addBashProfile

exit 0

