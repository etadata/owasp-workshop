# Version: 0.0.1
FROM ubuntu:16.04
MAINTAINER Souri Abdelhalim "abdelhalimsouri@gmail.com"
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Welcome to Owasp workshop 2018, from container' > /var/www/html/index.nginx-debian.html
EXPOSE 80
