# VSFTPD Server in a Docker

[![Discord](https://img.shields.io/discord/720919856815276063)](https://discord.com/channels/720919856815276063/774606101815099392)  
[![CircleCI Build Status](https://img.shields.io/circleci/project/million12/docker-vsftpd/master.svg)](https://circleci.com/gh/million12/docker-vsftpd/tree/master)
[![GitHub Open Issues](https://img.shields.io/github/issues/million12/docker-vsftpd.svg)](https://github.com/million12/docker-vsftpd/issues)
[![GitHub Stars](https://img.shields.io/github/stars/million12/docker-vsftpd.svg)](https://github.com/million12/docker-vsftpd)
[![GitHub Forks](https://img.shields.io/github/forks/million12/docker-vsftpd.svg)](https://github.com/million12/docker-vsftpd)  
[![Stars on Docker Hub](https://img.shields.io/docker/stars/million12/vsftpd.svg)](https://hub.docker.com/r/million12/vsftpd)
[![Pulls on Docker Hub](https://img.shields.io/docker/pulls/million12/vsftpd.svg)](https://hub.docker.com/r/million12/vsftpd)  
[![](https://images.microbadger.com/badges/version/million12/vsftpd.svg)](http://microbadger.com/images/million12/vsftpd)
[![](https://images.microbadger.com/badges/license/million12/vsftpd.svg)](http://microbadger.com/images/million12/vsftpd)
[![](https://images.microbadger.com/badges/image/million12/vsftpd.svg)](http://microbadger.com/images/million12/vsftpd)  

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/million12/docker-vsftpd/tree/master)  

This vsftpd docker image is based on official CentOS 7 image and comes with following features:  

  * Virtual users
  * Passive mode (`ports 21100-21110`)
  * Logging to a file or STDOUT
  * Anonymous account access (defined by user on docker run `true/false`)

### Environmental Variables

|FTP_USER||
|---|---|
|Default:|`FTP_USER=admin` |
|Accepted values:|Any string. Avoid whitespaces and special chars.|
|Description:|Username for the default FTP account. If you don't specify it through the `FTP_USER` environment variable at run time, `admin` will be used by default.|  

|FTP_PASS||
|---|---|
|Default:|`FTP_PASS=random`|
|Accepted values:|Any string.|
|Description:|If you don't specify a password for the default FTP account through `FTP_PASS`, a 16 characters random string will be automatically generated. You can obtain this value through the [container logs](https://docs.docker.com/reference/commandline/logs/).|

|LOG_STDOUT||
|---|---|
|Default:|`LOG_STDOUT=false`|
|Accepted values:|`true` or `false`|
|Description:|Output vsftpd log through STDOUT, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).|

|ANONYMOUS_ACCESS||
|---|---|
|Default:|`ANONYMOUS_ACCESS=false`|
|Accepted values:|`true` or `false`|
|Description:|Grants access to user `anonymous` need to have access to files in `/var/ftp/pub` directory.|

|UPLOADED_FILES_WORLD_READABLE||
|---|---|
|Default:|`UPLOADED_FILES_WORLD_READABLE=false`|
|Accepted values:|`true` or `false`|
|Description:|Changes the permmissions of uploaded files to `rw- r-- r--`. This makes files readable by other users.|

|CUSTOM_PASSIVE_ADDRESS||
|---|---|
|Default:|`CUSTOM_PASSIVE_ADDRESS=false`|
|Accepted values:|`ip address` or `false`|
|Description:|Passive Address that gets advertised by vsftpd when responding to PASV command. This is useul when running behind a proxy, or with docker swarm.|


### Basic usage

    docker run \
      --name vsftpd \
      -d \
      million12/vsftp

example output of `docker logs vsftpd`

```
[VSFTPD 11:00:46] Created home directory for user: admin
[VSFTPD 11:00:46] Updated /etc/vsftpd/virtual_users.txt
[VSFTPD 11:00:46] Updated vsftpd database
[VSFTPD 11:00:46] Fixed permissions for newly created user: admin
       	SERVER SETTINGS
       	---------------
       	· FTP User: admin
       	· FTP Password: Al5HpyJtUp3fQiEe
       	· Log file: /var/log/vsftpd/vsftpd.log
[VSFTPD 11:00:46] VSFTPD daemon starting
```

### Custom usage

    docker run \
      --name vsftpd \
      -d \
      -e FTP_USER=www \
      -e FTP_PASS=my-password \
      -e ANONYMOUS_ACCESS=true \
      -p 20-21:20-21 \
      -p 21100-21110:21100-21110 \
      million12/vsftpd

example output of `docker logs vsftpd`

```
[VSFTPD 11:04:43] Enabled access for anonymous user.
[VSFTPD 11:04:43] Created home directory for user: www
[VSFTPD 11:04:43] Updated /etc/vsftpd/virtual_users.txt
[VSFTPD 11:04:43] Updated vsftpd database
[VSFTPD 11:04:43] Fixed permissions for newly created user: www
       	SERVER SETTINGS
       	---------------
       	· FTP User: www
       	· FTP Password: my-password
       	· Log file: /var/log/vsftpd/vsftpd.log
[VSFTPD 11:04:43] VSFTPD daemon starting
```

**since `docker version 1.5` ports can be exported in range**


Docker troubleshooting
======================

Use docker command to see if all required containers are up and running:
```
$ docker ps
```

Check logs of docker container:
```
$ docker logs vsftpd
```

Sometimes you might just want to review how things are deployed inside a running
 container, you can do this by executing a _bash shell_ through _docker's
 exec_ command:
```
docker exec -ti vsftpd /bin/bash
```

History of an image and size of layers:
```
docker history --no-trunc=true million12/vsftpd | tr -s ' ' | tail -n+2 | awk -F " ago " '{print $2}'
```

## Author

Author: Przemyslaw Ozgo (<przemek@m12.io>)  
This work is also inspired by [fauria](https://github.com/fauria)'s [work](https://github.com/fauria/docker-vsftpd). Many thanks!

---

**Sponsored by [Prototype Brewery](http://prototypebrewery.io/)** - the new prototyping tool for building highly-interactive prototypes of your website or web app. Built on top of [Neos CMS](https://www.neos.io/) and [Zurb Foundation](http://foundation.zurb.com/) framework.
