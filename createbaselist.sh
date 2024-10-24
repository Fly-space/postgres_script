createbaselist.sh  createbase.sh      
postgres@Srv-w-Pg1c01:/var/pgscripts$ cat createbaselist.sh 
#!/bin/sh
sudo -i -u postgres psql -A -q -t  -c "select datname from pg_database" >  /var/pgscripts/databases.conf