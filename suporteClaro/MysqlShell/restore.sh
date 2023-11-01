/mysql/backup/mysql-shell-commercial-8.0.33-linux-glibc2.12-x86-64bit/bin/mysqlsh  -umysqlbackup -pSenha#01 -hlocalhost --socket=/mysql/mysql.sock  --js <<EOF

util.loadDump('/mysql/backup/clstsgslx4566/Master/202305121545',{ threads:35, loadUsers: true, resetProgress: true, characterSet: 'utf8mb4', deferTableIndexes: 'all' })
  
  EOF
