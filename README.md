# Dockerized pepcomposer

This Dockerized version of pepcomposer is needed due to incompatible versions of libc6 with some components of the pipeline, mainly Triangle Match.

The base system is debian 8 (Jessie) which is known to work and on which pepcomposer was developed.

The source code for pepcomposer is not included in the repository.

## Starting the container
`docker run --rm -d -p 8778:80 pepcomposer:alpha  /usr/sbin/apache2ctl -D FOREGROUND`

