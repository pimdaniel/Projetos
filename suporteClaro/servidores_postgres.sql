

#P0stSQL#
#P0stSQL#2

##############################################################################################################################


CBC2AM00354 - 10.88.14.35

ATHENA 1 (MEDWEB)

ssh postgre@10.88.14.35 


##############################################################################################################################


CBC2AM80574 - 10.88.14.36


ATHENA 2 (MEDWEB)

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


##############################################################################################################################

# PostgreSql - RPMs

vcopscaslx15 10.88.68.15
vcopsdlelx44 10.88.68.44  
vcopsdlelx45 10.88.68.45
vcopsdlelx46 10.88.68.46
vcopsdlelx47 10.88.68.47


##############################################################################################################################
