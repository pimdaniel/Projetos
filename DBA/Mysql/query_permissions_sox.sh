#!/bin/bash

DATE=`date +%d%m%Y`
export DATE


mysql -umonsite -pmonitora mysql < /mysql/sow_sql.sql  > query_permissions_sox_TMP.txt

awk -f query_permissions_sox.awk  query_permissions_sox_TMP.txt > query_permissions_sox_$DATE.csv
