# docker-compose-semaphore

A set of dockerized apps to support Semaphore, a web application for Ansible.

There are three applications:
- Apache httpd - to deal with SSL. (HTTPS)
- Semaphore - the application itself.
- MySQL - to store persistent data

## Running the application
In order to run this application, run these commands:

    git clone https://github.com/robertdebock/docker-compose-semaphore.git
    cd docker-compose-semaphore
    docker-compose up

When started, press CTRL+C or "docker-compose stop" to (temporarily) stop it. When using "docker-compose start", all persistent data will be in tact.

Login with the default username / password combination:
- username: semaphore
- password: semaphore

## Customizing the application
You may want to customize variables.env, where you can add Apache HTTPD settings like so:

    SERVERNAME=semaphore.meinit.nl:443
    SERVERADMIN robert@meinit.nl
    SSL_COUNTRY NL
    SSL_STATE UTRECHT
    SSL_LOCATION Breukelen
    SSL_ORGANIZATION Me in IT Consultancy
    SSL_ORGANIZATIONAL_UNIT IT Department
    SSL_COMMONNAME semaphore.meinit.nl

## Managing the application
Two scripts have been added:
- scripts/backup.sh - Backs up: mysql, /tmp and /root/.ssh/
- scripts/restore.sh - Restores the backup.

Restoring is only required when the volumes have been removed, so either because "docker-compose down" was issued of when the Docker engine has been changed.
