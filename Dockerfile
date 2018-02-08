FROM debian:8

LABEL maintainer="Bioinformatics group Sapienza" 
LABEL description="Docker image with prerequisites to run pepcomposer. Pepcomposer files must be mounted as an external volume. The image uses a oldstable debian for compatibility with TriangleMatch and libc6."

ENV _UPDATED_ON 2018.02.06

# Switch to root for installing prerequisites
USER root

RUN dpkg --add-architecture i386
# needed files (apache + php)
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-php5 php5 ghostscript dssp libc6:i386 python-networkx libgl1-mesa-glx; \
    rm -r /var/lib/apt/lists/*; \
    apt-get autoremove; apt-get clean 

# copy pepcomposer needed programs
RUN mkdir /var/www/pepcomposer
COPY pepcomposer_files/NeededSW/chimera-1.10-linux_x86_64.bin /tmp/
RUN chmod +x /tmp/chimera-1.10-linux_x86_64.bin 

WORKDIR /var/www/pepcomposer

# Adjust file permissions
RUN chown www-data /var/www/pepcomposer

# NOTE!!
# Chimera must be manually installed in container and
# the image saved using
#	# docker commit
#

################################################
# change user to www-data to run pepcomposer
# but only whe it is production ready...
# also, remove unneded files

#RUN rm /tmp/*.bin
#USER www-data
EXPOSE 80

CMD [/bin/bash] 
