FROM debian:8

LABEL maintainer="Bioinformatics group Sapienza" 
LABEL description="Docker image with prerequisites to run pepcomposer. Pepcomposer files must be mounted as an external volume. The image uses a oldstable debian for compatibility with TriangleMatch and libc6."

ENV _UPDATED_ON 2018.03.29

# Switch to root for installing prerequisites
USER root

RUN dpkg --add-architecture i386
# needed files (apache + php)
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-php5 \
	php5 ghostscript dssp libc6:i386 python-networkx \ 
    libgl1-mesa-glx unzip; \
    rm -r /var/lib/apt/lists/*; \
    apt-get -y autoremove; \
	apt-get clean; \
	rm -rf /var/lib/apt 

# copy pepcomposer needed programs
WORKDIR /tmp
COPY pepcomposer_files/NeededSW/chimera-1.10-linux_x86_64.bin ./
RUN mkdir chimera && unzip chimera-1.10-linux_x86_64.bin -d chimera
# Install chimera with default options
RUN  cd chimera && printf '\n\n' | ./installer /opt/UCSF && cd .. && rm -rf chimera*

RUN mkdir /var/www/pepcomposer
WORKDIR /var/www/pepcomposer

# Adjust file permissions
RUN chown www-data /var/www/pepcomposer

# Set up apache conf
COPY pepcomposer_files/pepcomposer_apache.conf /etc/apache2/sites-enabled/pepcomposer.conf
# change user to www-data to run pepcomposer
# but only when it is production ready...
# also, remove unneeded files

#USER www-data
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#CMD /bin/bash 
