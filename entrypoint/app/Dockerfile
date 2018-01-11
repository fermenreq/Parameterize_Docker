FROM httpd:2.4

MAINTAINER fernando.mendez.external@atos.net

ARG ARG1

RUN apt-get update && \
    apt-get -qq install -y \
    apache2

#Send index.html to htdocs
ADD index.html /usr/local/apache2/htdocs/index.html

#Set up $ARG1 to index.html file
#RUN echo "$ARG1" >> /usr/local/apache2/htdocs/index.html

ENTRYPOINT ["/usr/local/apache2/htdocs/index.html","$ARG1"]

