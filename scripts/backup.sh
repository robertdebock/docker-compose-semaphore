#!/bin/bash

if [ ! -d data ] ; then
  mkdir data
fi

backupdatabase() {
  docker exec mysql sh -c 'exec mysqldump --all-databases -usemaphore -p"semaphore"' > data/database.mysql
}

backupfiles() {
 for directory in /tmp /root/.ssh ; do 
   filename=$(echo ${directory} | sed 's%/%%g').tar.gz
   echo "Backing up ${directory}..."
   docker exec semaphore /bin/bash -c "cd ${directory} ; tar -czf - *" > data/${filename}
 done
}

backupdatabase
backupfiles
