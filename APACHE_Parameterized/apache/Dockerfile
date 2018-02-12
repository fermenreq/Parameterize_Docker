FROM ubuntu

MAINTAINER Fernando Méndez Requena - fernando.mendez.external@atos.net

#Update the repository sources list
RUN apt-get update

#Install and run apache
RUN apt-get install -y apache2 && apt-get clean

ENV DIR_APACHE=/apache
RUN mkdir $DIR_APACHE
WORKDIR $DIR_APACHE

#ADD mpm_prefork.conf $DIR_APACHE

RUN cd /etc/apache2/mods-available && \
    chmod 700 mpm_prefork.conf && \
    echo "envsubst < $DIR_APACHE/mpm_prefork-template.conf > ./mpm_prefork.conf"
    
EXPOSE 80

CMD apachectl -D FOREGROUND
