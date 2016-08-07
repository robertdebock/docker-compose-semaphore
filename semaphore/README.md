# Dockerized semaphore web application

This container contains the application semaphore, a web interface for Ansible.

- Default username: semaphore
- Default password: semaphore

This application can't be used without MySQL, so it's quite commmon to use this container with 'docker-compose'. (This will manage multiple container as once.) Have a look at https://github.com/robertdebock/docker-compose-semaphore for an example.

