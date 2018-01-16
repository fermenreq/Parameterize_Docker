####################################################################
# DOCKERFILE to build Nginx installed containers 
####################################################################

ARG VERSION=xenial
ARG PORT=80

FROM ubuntu:$VERSION

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

EXPOSE $PORT

CMD service nginx start
