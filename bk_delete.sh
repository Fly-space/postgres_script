#!/bin/sh

path="/var/pgscripts/databases.conf";

for p in `cat "$path"`;
        do
        [ -d /mnt/sdb/backup/$p ] && rm -fr /mnt/sdb/backup/$p
        done;
exit 0;
