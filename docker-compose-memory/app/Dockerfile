FROM httpd:2.4

MAINTAINER fernando.mendez.external@atos.net

RUN apt-get update && \
    apt-get -qq install -y \
    apache2

#Send index.html to htdocs
ADD index.html /usr/local/apache2/htdocs/index.html

