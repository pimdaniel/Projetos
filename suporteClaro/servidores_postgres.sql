

#P0stSQL#
#P0stSQL#2
#P0stSQL#3

select t1.datname AS db_name,  
       pg_size_pretty(pg_database_size(t1.datname)) as db_size
from pg_database t1
order by pg_database_size(t1.datname) desc;

##############################################################################################################################


CBC2AM00354 - 10.88.14.35

ATHENA 1 (MEDWEB)

ssh postgre@10.88.14.35 

ATHENA 1 (MEDWEB)- CBC2AM00354 - 10.88.14.35
bases:
irpt      | 45 GB
 cca       | 43 GB
 ndi       | 20 GB
 srt       | 249 MB




##############################################################################################################################


CBC2AM80574 - 10.88.14.36


ATHENA 2 (MEDWEB) - CBC2AM80574 - 10.88.14.36
bases:
 faturamentoresidencial | 169 GB
 medwebnovo             | 59 GB
 igr                    | 29 GB
 faturamentoempresarial | 29 GB
 tabelas                | 10 GB
 faturamentomovel       | 2427 MB
 cobilling              | 573 MB
 faturamentopessoal     | 39 MB
 inovacao               | 8353 kB




ssh postgre@10.88.14.36

Restores:

nohup  psql -h localhost -U postgres -d faturamentoPessoal < /backup/dump/faturamentoPessoal_bkp.backup &

##############################################################################################################################


CBC2BM69498 - 10.88.14.75	

SMARTRULES

ssh postgre@10.88.14.75


Restores:

01 - nohup pg_restore --host=localhost --port=5432 --username=postgres --clean --dbname=postgres --verbose /backup/dump/backup_postgresql10_20032024.backup &
02 - nohup pg_restore --host=localhost --port=5432 --username=postgres --clean --dbname=postgres --verbose  /backup/dump/backup_postgresql7_20032024.backup &

SMARTRULES - CBC2BM69498 - 10.88.14.75	
bases:
postgres - 1568 GB

##############################################################################################################################

# PostgreSql - RPMs

vcopscaslx15 10.88.68.15
vcopsdlelx44 10.88.68.44  
vcopsdlelx45 10.88.68.45
vcopsdlelx46 10.88.68.46
vcopsdlelx47 10.88.68.47


##############################################################################################################################
