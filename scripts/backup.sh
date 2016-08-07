#!/bin/bash

backupdatabase() {
  docker exec dockercomposesemaphore_mysql_1 sh -c 'exec mysqldump --all-databases -usemaphore -p"semaphore"' > data/database.mysql
}

backupfiles() {
 for directory in /tmp ; do 
   filename=$(echo ${directory} | sed 's%/%%g').tar.gz
   echo "Backing up ${directory}..."
   docker exec dockercomposesemaphore_semaphore_1 /bin/bash -c "cd ${directory} ; tar -czf - *" > data/${filename}
 done
}

backupdatabase
backupfiles
