# Parameterize Docker-compose and Dockerfile

This project show you the principal ways to parameterize several apps using docker.

1. Docker build args

In this example we are going to generate new content at the end of a html file called index.html. For that in docker-compose file, you can specify values to pass on for ARG, in an args block

Those ARG variables will not be available in containers started based on the built image without further work. If you want ARG entries to change and take effect, you need to build a new image. Probably you’ll need to manually delete any old ones.

Example 1:
```
 ./docker:
   ./app
     DockerFile
     index.html
   ./nginx
     DockerFile
     nginx.conf
   docker-compose.yml 
```
## Installation Steps:
 ```
 root@osboxes:/home/osboxes/Desktop/# git clone: https://github.com/fermenreq/Parameterize_Docker.init
```

1.1 Build the image
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
1.2 Deploy the image:
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker-compose up -d
Creating solution1_app_1_1
Creating solution1_app_3_1
Creating solution1_app_2_1
Creating solution1_proxy_1

```
1.3 Search the Containers IP addres: (i.e: service_web 2)
```
root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                           PORTS                  NAMES
9e694042d56d        solution1_proxy     "/bin/sh -c 'service…"   4 seconds ago       Up 2 seconds                     0.0.0.0:8080->80/tcp   solution1_proxy_1
c11db845081c        solution1_app_2     "httpd-foreground"       6 seconds ago       Up 4 seconds                     80/tcp                 solution1_app_2_1
23c5a0c918b8        solution1_app_3     "httpd-foreground"       6 seconds ago       Up 3 seconds                     80/tcp                 solution1_app_3_1
c29210ad4635        solution1_app_1     "httpd-foreground"       6 seconds ago       Up 4 seconds                     80/tcp                 solution1_app_1_1

root@osboxes:/home/osboxes/Desktop/Parameterize_Docker/solution_1# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' c11db845081c
172.28.0.3
```
1.4 Use Curl commands or explorer to see results:

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
	   © <a href="http://github.com/fermenreq">Fernando Mendez Requena</a> (<a href="mailto:fernando.mendez.external@atos.net">fernando.mendez.external@atos.net</a>) / 2018-01-10
	  </address>
	</body>

</html>
You deploy the service app_2
```

2. Docker Compose 
3. Docker entrypoint
