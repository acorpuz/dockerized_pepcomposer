FROM debian:8

LABEL maintainer="Bioinformatics group Sapienza" 
LABEL description="Docker image with prerequisites to run pepcomposer. Pepcomposer files must be mounted as an external volume. The image uses a oldstable debian for compatibility with TriangleMatch and libc6."

ENV _UPDATED_ON 2018.02.06

# Switch to root for installing prerequisites
USER root

RUN dpkg --add-architecture i386
# needed files (apache + php)
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-php5 php5 ghostscript dssp libc6:i386 python-networkx; \
    rm -r /var/lib/apt/lists/*; \
    apt-get autoremove; apt-get clean 

# copy pepcomposer files
#COPY pepcomposer /var/www/

WORKDIR /var/www/pepcomposer

EXPOSE 80

# change user to www-data to run pepcomposer
USER www-data
#CMD [] 
