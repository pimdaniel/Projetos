DATE=`date +%d%m%Y`
export DATE

user="dbmon"
pass="monitor"
_mysql=$(which mysql)
site='MKZ'
host=`hostname`

# db_name,-- valor vem da query
versa=$($_mysql -u$user -p$pass -D mysql -B -s -e 'SELECT SUBSTRING(version(),1,3);');
release=$($_mysql -u$user -p$pass -D mysql -B -s -e 'SELECT SUBSTRING(version(),5,2);');
tipo='PRD'
administracao='ORA'
BD24='S'
no_ar='S'
em_manutencao='N'
legado='N'
script_path=''
sistema='SGE'
producao=''
origem='EBT'
ip_address='10.88.132.98'
creation_date='NULL'
critico='N'
platform_id='NULL'
platform_name='NULL'
lgpd='N'

rm tmp.txt

for db in $($_mysql -u$user -p$pass -D mysql -B -s -e 'show databases;'); do


        $($_mysql -u$user -p$pass -D mysql -B -s -e "select 'insert#into#DATABASES_MYSQL# (site,host,db_name,versao,release,tipo,administracao,', concat('\"','24/7','\"'), ',no_ar,em_manutencao,legado,script_path,sistema,producao,origem,ip_address,creation_date,critico,platform_id,platform_name, lgpd )#values#(',concat('\'','$site','\'') ',',',',concat('\'','$host','\'') ',',','  , concat('\'','$db','\''),',', concat('\'',$versa,'\''),',',concat('\'',$release,'\''), ',',concat('\'','$tipo','\''),',',concat('\'','$administracao','\''),',',concat('\'','$BD24','\''),',',concat('\'','$no_ar','\''),',',concat('\'','$em_manutencao','\''),',',concat('\'','$legado','\''),',',concat('\'','$script_path','\''),',',concat('\'','$sistema','\''),',',concat('\'','$producao','\''),',',concat('\'','$origem','\''),',',concat('\'','$ip_address','\''),',','$creation_date',',', concat('\'','$critico','\'') ,',','$platform_id' ,',','$platform_name',',',concat('\'','$lgpd','\''),')';" >> tmp.txt);


done

#Retira todos dos espacos do aquivo
sed 's/[[:space:]]//g' tmp.txt > inv_$DATE.txt

#Substitui os valores de # para espaco pois alguns pontos precisam de espaco
sed -i 's/#/ /g' inv_$DATE.txt
