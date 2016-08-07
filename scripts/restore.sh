#!/bin/bash -x

restoredatabase() {
  docker exec -i mysql mysql -usemaphore -p"semaphore" < data/database.mysql
}

restorefiles() {
  for directory in /tmp /root/.ssh ; do
    filename=$(echo ${directory} | sed 's%/%%g').tar.gz
    cat data/${filename} | docker exec -i semaphore /bin/bash -c "cat > ${dirname}/${filename}"
    docker exec semaphore bash -c "test -d ${directory} || mkdir ${directory}"
    docker exec semaphore tar -xvzf ${dirname}/${filename} -C ${directory}
  done
}

restoredatabase
restorefiles
