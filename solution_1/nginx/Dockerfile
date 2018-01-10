####################################################################
# DOCKERFILE to build Nginx installed containers 
####################################################################

FROM ubuntu:xenial

MAINTAINER fernando.mendez.external@atos.net

#Install necessary tools
RUN apt-get update && \ 
    apt-get -qq install -y \ 
    nano wget dialog net-tools \
    nginx

#Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD service nginx start
