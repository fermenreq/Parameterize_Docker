# Parameterize Docker-compose and Dockerfile

This project show you the principal ways to parameterize several apps using docker. Dont forget that you can combine all options together.



## 1. Using Docker build args

In this example we are going to generate new content at the end of a html file called index.html. For that in docker-compose file, you can specify values to pass on for ARG, in an args block

Those ARG variables will not be available in containers started based on the built image without further work. If you want ARG entries to change and take effect, you need to build a new image. Probably you’ll need to manually delete any old ones.

## Example: Project Tree
```
 ./solution_1:
   ./app
     DockerFile
     index.html
   ./nginx
     DockerFile
     nginx.conf
   docker-compose.yml 
```
**Installation Steps:**
 ```
git clone: https://github.com/fermenreq/Parameterize_Docker.init
```

 **1.1 Build the image**
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker-compose build --no-cache
Building app_1
Step 1/6 : FROM httpd:2.4
 ---> 7239615c0645
Step 2/6 : MAINTAINER fernando.mendez.external@atos.net
 ---> Running in ba37d874bfbe
Removing intermediate container ba37d874bfbe
 ---> dd35a53521ab
Step 3/6 : ARG ARG1
 ---> Running in 65c6f4a88c58
Removing intermediate container 65c6f4a88c58
 ---> e36ff7ea0e83
Step 4/6 : RUN apt-get update &&     apt-get -qq install -y     apache2
 ---> Running in 26d31da2df22
Get:1 http://security.debian.org jessie/updates InRelease [63.1 kB]
Get:2 http://security.debian.org jessie/updates/main amd64 Packages [605 kB]
.....
```
**1.2 Deploy the image:**
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker-compose up -d
Creating solution1_app_1_1
Creating solution1_app_3_1
Creating solution1_app_2_1
Creating solution1_proxy_1

```
**1.3 Search the Containers IP addres: (i.e: service_web 2)**
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                           PORTS                  NAMES
9e694042d56d        solution1_proxy     "/bin/sh -c 'service…"   4 seconds ago       Up 2 seconds                     0.0.0.0:8080->80/tcp   solution1_proxy_1
c11db845081c        solution1_app_2    "httpd-foreground"       6 seconds ago       Up 4 seconds                     80/tcp                 solution1_app_2_1
23c5a0c918b8        solution1_app_3     "httpd-foreground"       6 seconds ago       Up 3 seconds                     80/tcp                 solution1_app_3_1
c29210ad4635        solution1_app_1     "httpd-foreground"       6 seconds ago       Up 4 seconds                     80/tcp                 solution1_app_1_1

root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' c11db845081c
172.28.0.3
```
**1.4 Use Curl commands or web explorer to see results:**
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# curl http://172.28.0.3:80
<html>
	<head>
  		<title>
		   Hello World Demonstration Document
		</title>
	 </head>
 	<body>
	  <h1>
	  	 Hello, Docker!
	  </h1>
	  <p>
	   This is a minimal "hello docker" HTML document. It demonstrates the
	   use of Docker build ARGS.
	  </p>
	  <p>
	   See me: <a href="https://es.linkedin.com/in/fmendez1">https://es.linkedin.com/in/fmendez1</a>
	  </p>
	  <hr>
	  <address>
	   © <a href="http://github.com/fermenreq">Fernando Mendez Requena</a> (<a 		   href="mailto:fernando.mendez.external@atos.net">fernando.mendez.external@atos.net</a>) / 2018-01-10
	  </address>
	</body>
</html>
```
**You deploy the service app_2**

## 2. Using Docker Compose

It's possible to use docker-compose in order to use a more elegant solution. It allows us to scale it without building the containers firstly. In this case we are going to have the same service deployed

root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_2/app# **docker-compose scale app=3 proxy=1**

```
Creating and starting solution2_app_1 ... done
Creating and starting solution2_app_2 ... done
Creating and starting solution2_app_3 ... done
Creating and starting solution2_proxy_1 ... done
```

```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_2/app# docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
d8f6d94a906f        solution2_proxy     "/bin/sh -c 'service…"   3 seconds ago       Up 2 seconds        0.0.0.0:8080->80/tcp   solution2_proxy_1
bd0c7c7b3698        solution2_app       "httpd-foreground"       6 seconds ago       Up 4 seconds        80/tcp, 5000/tcp       solution2_app_3
c64b0f6506df        solution2_app       "httpd-foreground"       6 seconds ago       Up 3 seconds        80/tcp, 5000/tcp       solution2_app_2
0bb5e95d491        solution2_app       "httpd-foreground"       6 seconds ago       Up 2 seconds        80/tcp, 5000/tcp       solution2_app_1
```

```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_2/app# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 0bb5e95d4914
172.29.0.3
```

```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_2/app# curl http://172.29.0.3
<html>
	<head>
  		<title>
		   Hello World Demonstration Document
		</title>
	 </head>
 	<body>
	  <h1>
	  	 Hello, Docker!
	  </h1>
	  <p>
	   This is a minimal "hello docker" HTML document. It demonstrates the
	   use of Docker build ARGS.
	  </p>
	  <p>
	   See me: <a href="https://es.linkedin.com/in/fmendez1">https://es.linkedin.com/in/fmendez1</a>
	  </p>
	  <hr>
	  <address>
	   © <a href="http://github.com/fermenreq">Fernando Mendez Requena</a> (<a href="mailto:fernando.mendez.external@atos.net">fernando.mendez.external@atos.net</a>) / 2018-01-10
	  </address>
	</body>

</html>

```

## 3.Using docker-compose env file

**Using environment variables in nginx configuration**

Out-of-the-box, nginx doesn’t support environment variables inside most configuration blocks. But envsubst may be used as a workaround if you need to generate your nginx configuration dynamically before nginx starts. For that I create an script called **up.sh**

**3.1 up.sh**
```
#!/bin/bash

echo "killing all project containers:"
docker rmi -f $(docker images)

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$WORKER_PROCESSES'
envsubst "$NGINX_VARS" < ./nginx-template.conf > nginx.conf

sudo docker-compose up -d
```
**3.2 nginx-template.conf**

```
worker_processes ${WORKER_PROCESSES};
events { worker_connections 1024; }
http {
    sendfile on;
    upstream app_servers {
        server app_1:80;
        server app_2:80;
        server app_3:80;
    }
    server {
        listen 8080;
        location / {
            proxy_pass         http://app_servers;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
    }
}

```
To set up the ```${WORKER_PROCESSES} ``` we are declare it on .env file

**3.3 .env**

```
#nginx server config
WORKER_PROCESSES=4
```

Finaly we set up our **docker-compose file** that allow us for variable substitution:

```
.....

 proxy:
    build:
      context:  ./nginx
      dockerfile: Dockerfile
    environment:
        - WORKER_PROCESSES=${WORKER_PROCESSES}
    ports:
      - "8080:80"
    links:
      - app_1
      - app_2
      - app_3

```

## 4.Docker ENV (without external .env file)

The goal of this section is the same you read before (3. docker env file), but the difference is: Here we are going to use **Enviroment variables** but without an external .env file.

In this case we are going to use again **envsubst** but in another way:

**4.1 docker-compose**

```
proxy:
    build:
      context:  ./nginx
      dockerfile: Dockerfile
    environment:
        - WORKER_PROCESSES=4
        - WORKER_CONNECTIONS=1024
        - PORT_LISTEN=8080
        - SERVICE_APP1=APP1
        - SERVICE_APP2=APP2
        - SERVICE_APP3=APP3
        - SERVICE_PORT=80
    ports:
      - "8080:80"
    links:
      - app_1
      - app_2
- app_3

```
**4.2 DockerFile**

We use **envsubst** here

```
   ...
   ...
EXPOSE $PORT
RUN echo "envsubst < ./nginx/nginx-template.conf > ./nginx/nginx.conf && nginx -g 'daemon off;'"
CMD service nginx start

```
**4.3 nginx-conf file**

```
worker_processes ${WORKER_PROCESSES};
events { worker_connections ${WORKER_CONNECTIONS}; }
http {
    sendfile on;
    upstream app_servers {
        server ${SERVICE_APP1}:${SERVICE_PORT};
        server ${SERVICE_APP2}:${SERVICE_PORT};
        server ${SERVICE_APP3}:${SERVICE_PORT};
    }
    server {
        listen ${PORT_LISTEN};
        location / {
            proxy_pass         http://app_servers;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
    }
}

```
## 5. Docker-compose limit resources: Docker Swarm (In progress....)

The following topics describe available options to set resource constraints on **services or containers in a swarm**. Docker compose format must be: **version:'3'**


**5.1 Requirements**

```
root@osboxes:/home/osboxes/Desktop/Proyectos/STAMP/prueba# docker-compose --version
docker-compose version 1.18.0, build 8dd22a9
```
 If you want to set resource constraints on non swarm deployments, use [Compose file format version 2 CPU, memory,and other resource options](https://docs.docker.com/compose/compose-file/compose-file-v2/#cpu-and-other-resources)

```
docker-machine version 0.13.0, build 9ba6da9
```

In this case we are going to create one VM to populate the swarm:

**Docker Swarm Init**

```
Swarm initialized: current node (ju1ilhm35iifbsv8hhm914myj) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1yqj4l6w6ucfm8tbvwb4uvbc5a5w825czcwemf2tyuwt4wqe6j-207dh3l5x1ocg9vbkhh407yk0 192.168.1.35:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.


```

**5.3 docker-compose**

In this general example, the nginx service is constrained to use **no more than 50M of memory and 0.50 (50%) of available processing time (CPU)**, and has **20M of memory and 0.25 CPU time reserved** (as always available to it).


```
version: '3'

services:
  app:
    build:
      context:  ./app
      dockerfile: Dockerfile
    expose:
      - "5000"
  proxy:
    build:
      context:  ./nginx
      dockerfile: Dockerfile
    ports:
      - "8080:80"
    links:
      - app
    deploy:
      resources:
        limits:
          cpus: '0.50'
          memory: 50M
        reservations:
          cpus: '0.25'
          memory: 20M

```


# 6. How to customize the configuration file of the official PostgreSQL Docker image?

## 6.1 Replacing custom configuration files 

You can put your custom **postgresql.conf** in a temporary file inside the container, and overwrite the default configuration at runtime.

To do that:

We are going to copy our custom **postgresql-template.conf** setting up some variables inside the container using **envsubst** script.

**Dockerfile:**
 
```
FROM ubuntu

MAINTAINER  Fernando Mendez Requena <fernando.mendez.external@atos.net>

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3


# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf


ADD postgresql-template.conf /db

RUN cd /etc/postgresql/9.3/main  && \
    COPY postgresql.conf /etc/postgresql/9.3/main \
    echo "envsubst < postgresql-template.conf > ./db/postgresql.conf"
    
WORKDIR /docker-entrypoint-initdb.d/

ADD init-db.sql /docker-entrypoint-initdb.d

# Expose the PostgreSQL port
EXPOSE 5432
 ```
 
**Postgresql-template.conf:**
```
...
...
max_connections = ${max_connections}
shared_buffers = ${shared_buffers}
...
...
```

**Docker-compose:**

```
version: '2'

services:
  db:
    build: ./db
    environment:
      - POSTGRES_DB=......
      - POSTGRES_USER=......
      - POSTGRES_PASSWORD=...... 
      - PGDATA=/var/lib/postgresql/data/pgdata
      - max_connections=500
      - shared_buffers=256MB
```



## Bibliography

- [Docker Bibliography](https://docs.docker.com/)
- [Docker Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/#open-protocols-and-ports-between-the-hosts)
- [Docker machine](https://docs.docker.com/machine/install-machine/#how-to-uninstall-docker-machine)

## Authors

Fernando Méndez Requena - fernando.mendez.external@atos.net

