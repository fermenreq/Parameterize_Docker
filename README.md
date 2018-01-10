# Parameterize Docker-compose and Dockerfile

This project show you the principal ways to parameterize an app. In this case we are going to set up several templates using docker

1. Docker build args

In this example we are going to generate new content at the end of index.html. For that in docker-compose file, you can specify values to pass on for ARG, in an args block

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
```
root@osboxes:/home/osboxes/Desktop/docker# docker-compose build
```
2. Docker Compose 
3. Docker entrypoint
