#!/bin/sh

echo "Backup script execution started at `date +"%Y-%m-%d_%H-%M-%S"`" >> /var/log/postgresql/service.log;

#rm /var/pgscripts/mailbody.txt || { echo "Backup script failed with error while deleting mailbody file. Exiting..." >> /var/log/postgresql/service.log; exit 5; };
[ -f /var/pgscripts/mailbody.txt ] && rm -f /var/pgscripts/mailbody.txt  ||  touch /var/pgscripts/mailbody.txt

path="/var/pgscripts/databases.conf";

backupdb ()
{

Currtime=`date +"%Y-%m-%d_%H-%M"`
pg_dump -Fd "$1" -U postgres -j 8 -f  /mnt/sdb/backup/$1 >/tmp/result 2>&1
if [ "$?" -eq 0 ];
then
echo "Database $1 Backup Completed Successfuly at $Currtime \n" >>/var/pgscripts/mailbody.txt;
echo "Database $1 Backup Completed Successfuly at $Currtime" >>/var/log/postgresql/service.log;
else
dump_err=$(cat /tmp/result)
echo "Database $1 Backup Completed with Error at $Currtime. The error was $dump_err \n" >>/var/pgscripts/mailbody.txt;
echo "Database $1 Backup Completed with Error at $Currtime. The error was $dump_err" >>/var/log/postgresql/service.log; 
fi

rm -f /tmp/result

}

mailsend () {
body=$(cat /var/pgscripts/mailbody.txt)

 curl -s --url 'smtp://mail.server.log:25' --mail-from srv-1c17@server.log --mail-rcpt ivanov@mserver.log \
	-H "Subject: SRV-1c17 PG_dump summary" -H "From: srv-1c17@server.log" -H "To: ivanov@mserver.log" -F '=(;type=multipart/mixed' -F "=$body;type=text/plain"
}

for p in `cat "$path"`;
        do
                backupdb $p
        done;

mailsend;
