#!/bin/bash
SHELL=/bin/bash
read -e -p  "Имя базы для актуализации?"  NAMEBASE
namearchive=$NAMEBASE"_`date +%d-%m-%Y`"
backuppath="/mnt/sdc/Backup/"


sudo -i -u postgres pg_dump $NAMEBASE | gzip > $backuppath$namearchive".sql.gz"
echo 'Создана копия базы'
sudo -i -u postgres psql  -c "DROP DATABASE $NAMEBASE"
echo 'DROP базы'
sudo -i -u postgres psql  -c "DROP TABLESPACE $NAMEBASE"
echo 'DROP базы'
