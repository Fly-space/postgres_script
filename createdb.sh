#!/bin/sh
sudo -i -u postgres psql -A -q -t  -c "select datname from pg_database" >  /var/pgscripts/databases.conf

postgres@Srv-w-Pg1c01:/var/pgscripts$ cat createbase.sh 
#!/bin/bash
SHELL=/bin/bash
read -e -p  "Имя базы новой базы? "  NAMEBASE
namearchive=$NAMEBASE"_`date +%d-%m-%Y`"
DIR="/mnt/sdd/"
echo $DIR
DIRBASE=${DIR}${NAMEBASE}
echo  ${DIRBASE}
mkdir "$DIRBASE"
chown postgres:postgres "$DIRBASE"


sudo -i -u postgres psql  -c "CREATE TABLESPACE $NAMEBASE  LOCATION '$DIRBASE';"

sudo -i -u postgres psql  -c "CREATE DATABASE $NAMEBASE WITH TEMPLATE = template1c TABLESPACE = $NAMEBASE"
