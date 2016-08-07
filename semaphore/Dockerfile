FROM centos

EXPOSE 3000

RUN yum -y update && \
    yum -y install git epel-release && \
    yum -y install ansible && \
    yum clean all

RUN curl -L https://github.com/ansible-semaphore/semaphore/releases/download/v2.0.4/semaphore_linux_amd64 > /usr/bin/semaphore && \
    chmod 750 /usr/bin/semaphore

ADD semaphore.json /etc/semaphore.json
ADD ssh_config /root/.ssh/config

# Wait until the host "mysql" is available on port 3306.
CMD while [ $(timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' ; echo $?) != 0 ] ; do sleep 1 ; done ; /usr/bin/semaphore -config /etc/semaphore.json