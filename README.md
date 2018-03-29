# Dockerized pepcomposer

This Dockerized version of pepcomposer is needed due to incompatible versions of libc6 with some components of the pipeline, mainly Triangle Match.

The base system is debian 8 (Jessie) which is known to work and on which pepcomposer was developed.

The source code for pepcomposer is not included in the repository.

## Creating the container
The included Dockerfile installs the software needed to run pepcomposer.

### Issues and Notes
* Pepcomposer files are mounted as an external volume, this bring along issues with file permissions. We need to chmod selected directories to allow read/write access to the webserver user (www-data); as we know the UID of the user www-data (UID=33 for debian), we need to apply this ownership. The included script (`pepcomposer_files/set_volume_perm.sh`) will do this.

## Starting the container
~~`docker run --rm -d -p 8778:80 pepcomposer:<tag>  /usr/sbin/apache2ctl -D FOREGROUND`~~

`docker run -d -p 8778:80 -v $(pwd)/pepcomposer_files/pepcomposer/:/var/www/pepcomposer  pepcomposer:<tag>`

NOTE: this could be possibly changed to run a script.. 

