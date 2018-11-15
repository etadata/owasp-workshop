


###### Working with Docker images and repositories


- Listing Docker images

``` bash 
$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
rev3rse/webmap              latest              84dee9f4f3be        8 days ago          1.07GB
gitlab/gitlab-ce            latest              3089d4fcaa2d        2 weeks ago         1.56GB
ubuntu                      latest              ea4c82dcd15a        2 weeks ago         85.8MB
subfinder                   latest              b9aebef774d2        7 weeks ago         12.5MB
<none>                      <none>              b4e23c6838dc        7 weeks ago         392MB
alpine                      latest              196d12cf6ab1        7 weeks ago         4.41MB
prom/prometheus             latest              f57a6a8a933c        7 weeks ago         110MB
envoyproxy/envoy            latest              0334070d47aa        2 months ago        136MB
<none>                      <none>              68dae9f87806        2 months ago        471MB
filebrowser/filebrowser     latest              207eb3515bb2        2 months ago        31.4MB
jboss/base-jdk              8                   8618c5766ffe        2 months ago        471MB
mysql                       latest              29e0ae3b69b9        2 months ago        484MB
portainer/portainer         latest              6827bc26a94d        3 months ago        58.5MB
weaveworks/scope            1.9.1               4b07159e407b        3 months ago        68MB
<none>                      <none>              b64190e79e47        3 months ago        12.5MB
<none>                      <none>              8437f37d63d2        3 months ago        334MB
bkimminich/juice-shop       latest              3ae424d3b681        3 months ago        367MB
jenkins                     latest              cd14cecfdb3a        3 months ago        696MB
buoyantio/linkerd           1.4.5               77ea2323edaf        3 months ago        589MB
alpine                      3.7                 791c3e2ebfcb        4 months ago        4.2MB
webgoat/webgoat-8.0         latest              fe3e14780585        4 months ago        299MB
citizenstig/nowasp          latest              82e745ffc9fc        5 months ago        800MB
golang                      1.9.4-alpine3.7     fb6e10bf973b        8 months ago        269MB
google/cadvisor             latest              75f88e3ec333        11 months ago       62.2MB
cumulusnetworks/frrouting   latest              13e9d5074a76        13 months ago       243MB
jekyll/jekyll               3.2                 2b863c097a4c        13 months ago       340MB
hmlio/vaas-cve-2014-0160    latest              5ab4352f7a87        3 years ago         156MB
```
>> NOTE These local images live on our local Docker host in the /var/lib/docker
directory. Each image will be inside a directory named for your storage driver;
for example, aufs or devicemapper. You'll also find all your containers in the
/var/lib/docker/containers directory.

That image was downloaded from a repository. Images live inside repositories,
and repositories live on registries. The default registry is the public registry managed by Docker, Inc., Docker Hub.
>> TIP The Docker registry code is open source. You can also run your own registry,
as we'll see later in this chapter.


Running a tagged Docker image
``` bash 
docker run -it ubuntu:16.04 /bin/bash
Unable to find image 'ubuntu:16.04' locally
16.04: Pulling from library/ubuntu
18d680d61657: Already exists 
0addb6fece63: Already exists 
78e58219b215: Already exists 
eb6959a66df2: Already exists 
Digest: sha256:76702ec53c5e7771ba3f2c4f6152c3796c142af2b3cb1a02fce66c697db24f12
Status: Downloaded newer image for ubuntu:16.04
```
the syntax is : docker run -it container-image:tag /bin/bash
by default the tag is latest.

It's always a good idea to build a container from specific tags. That way we'll know
exactly what the source of our container is.


Pulling images

Pulling the nginx image:
``` bash  
$ docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
f17d81b4b692: Pull complete 
d5c237920c39: Pull complete 
a381f92f36de: Pull complete 
Digest: sha256:b73f527d86e3461fd652f62cf47e7b375196063bbbd503e853af5be16597cb2e
Status: Downloaded newer image for nginx:latest
```
 Viewing the Nginx image

``` bash 
$ docker images nginx 
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              dbfc48660aeb        2 weeks ago         109MB
```

- Searching for images

``` bash 
$ docker search owasp
NAME                                           DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
owasp/zap2docker-stable                        Current stable OWASP Zed Attack Proxy releas…   84                                      
owasp/zap2docker-weekly                        Weekly owasp zed attack proxy release in emb…   15                                      
owasp/modsecurity                              The Official ModSecurity Docker Image (No CR…   10                                      [OK]
owasp/glue                                     Run various OWASP (and other) security tools…   9                                       
owasp/dependency-check                         OWASP dependency-check detects publicly disc…   8                                       [OK]
danmx/docker-owasp-webgoat                     OWASP WebGoat Project docker image              8                                       
owasp/modsecurity-crs                          The Official OWASP Core Rule Set Docker Imag…   7                                       [OK]
owasp/benchmark                                Runs the latest version of OWASP Benchmark      6                                       
citizenstig/owaspbricks                        OWASP Bricks in docker container                6                                       [OK]
owasp/sonarqube                                This project aims to enable more security fu…   5                                       
owasp/zap2docker-live                          Live ZAP build - using the very latest sourc…   5                                       [OK]
owasp/railsgoat                                OWASP Railsgoat.                                4                                       [OK]
alirazmjoo/owaspnettacker                      OWASP Nettacker - Automated Penetration Test…   4                                       
feltsecure/owasp-bwapp                         This is a docker image containing OWASP bWAPP   2                                       [OK]
owasp/dependency-track                         Dependency-Track is an intelligent Software …   2                                       
owasp/zap2docker-bare                          Minimal version of current stable OWASP Zed …   2                                       
fujitsudas/pipeline-cloud-owasp-sonar-gradle   Docker image to efficiently build Spring Boo…   1                                       [OK]
gjuniioor/owasp-bricks                         OWASP Bricks                                    1                                       [OK]
embrasure/owasp-dependency-check               An alpine container containing version 1.4.3…   1                                       
owasp/o-saft                                   OWASP - SSL advanced forensic tool              1                                       
iniweb/owasp-zap2docker-stable                                                                 1                                       
nhantd/owasp_zap                               OWASP security test                             0                                       
runako/owasp-glue                              Fork of owasp/glue with improvements to OWAS…   0                                       
thepixelbro/owasp-proxy                                                                        0                                       
ibeanu/owasp-zap                               owasp-zap                                       0                                       
```
>> TIP You can also browse the available images online at Docker Hub.

Here, we've searched the Docker Hub for the term owasp . It'll search images and
return:

- Repository names
- Image descriptions
- Stars - these measure the popularity of an image
- Official - an image managed by the upstream developer (e.g., the fedora
image managed by the Fedora team)
- Automated - an image built by the Docker Hub's Automated Build process
  

Let's pull down the kali linux image.

``` bash 
$ docker search kali
NAME                           DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
kalilinux/kali-linux-docker    Kali Linux Rolling Distribution Base Image      522                                     [OK]
linuxkonsult/kali-metasploit   Kali base image with metasploit                 65                                      [OK]
jgamblin/kalibrowser           Kali in a Browser                               30                                      
```
then 
``` bash 
$ docker  pull kalilinux/kali-linux-docker
```

Creating a Docker container from the Kali master image
``` bash
docker run -i -t kalilinux/kali-linux-docker /bin/bash
root@d370dbeea32d:/# cat /etc/lsb-release 
DISTRIB_ID=Kali
DISTRIB_RELEASE=kali-rolling
DISTRIB_CODENAME=kali-rolling
DISTRIB_DESCRIPTION="Kali GNU/Linux Rolling"
root@d370dbeea32d:/# 
```

- Building our own images
So we have seen that we can pull down pre-prepared images with custom contents.
How do we go about modifying our own images and updating and managing them?
There are two ways to create a Docker image:

    - Via the docker commit command
    - Via the docker build command with a Dockerfile

>> The docker commit method is not currently recommended, as building with a
Dockerfile is far more flexible and powerful, but we'll demonstrate it to you for
the sake of completeness. After that, we'll focus on the recommended method of building Docker images: writing a Dockerfile and using the docker build
command.

Creating a Docker Hub account.

let's start by creating an account on the Docker Hub. You can the join Docker Hub :: https://hub.docker.com/account/signup/
then 
``` bash 
$ docker login 
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: abdelhalim
Password: 
Login Succeeded
```
Using Docker commit to create images

1 -  Creating a custom container to modify.

``` bash 
$ docker run -i -t ubuntu:16.04 /bin/bash
root@e9011614746e:/# 
```

2 - Adding the Apache package
``` bash 
    root@e9011614746e:/# apt update
    ....
    root@e9011614746e:/# apt -y install apache2
    ....
    root@e9011614746e:/# apt -y install curl
    root@e9011614746e:/# echo "Hello Owasp Lab" >  /var/www/html/index.html 
    root@e9011614746e:/# curl http://localhost 
    Hello Owasp Lab
    root@e9011614746e:/# exit
```
We've launched our container and then installed Apache within it. We're going
to use this container as a web server,so we'll want to save it in its current state.
That will save us from having to rebuild it with Apache every time we create a
new container. To do this we exit from the container, using the ``exit`` command,
and use the ``docker commit`` command.

Committing the custom container
``` bash 
$ docker commit e9011614746e abdelhalim/apache2
sha256:e72aae7c26665c6089384ba122fa92fcb3f81cff61bac264a6ab7894a5b10261
```
You can see we've used the docker commit command and specified the ID of the
container we've just changed (to find that ID you could use the ``docker ps -l -q`` command to return the ID of the last created container) as well as a target
repository and image name, here ``abdelhalim/apache2 ``. 
Of note is that the ``docker commit`` command only commits the differences between the image the container was created from and the current state of the container. This means updates are very lightweight

Reviewing our new image
``` bash 
$ docker images abdelhalim/apache2
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
abdelhalim/apache2   latest              e72aae7c2666        3 minutes ago       243MB
```
Committing another custom container
``` bash 
$ docker commit -m="A new custom image"  --author="Souri Abdelhalim" e9011614746e abdelhalim/apache2:webserver
sha256:80fe0583c0118368a0a55c11d0994331f880cc78891829baff5aebf6f7368669
```
we've specified some more information while committing our new image.
We've added the ``-m `` option which allows us to provide a commit message explaining our new image. We've also specified the ``--author`` option to list the author of
the image.

Inspecting our committed image
``` bash 
$ docker inspect abdelhalim/apache2:webserver
```
> TIP : You can find a full list of the docker commit flags
``` bash
$ docker commit --help 

Usage:	docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]

Create a new image from a container's changes

Options:
  -a, --author string    Author (e.g., "John Hannibal Smith <hannibal@a-team.com>")
  -c, --change list      Apply Dockerfile instruction to the created image
  -m, --message string   Commit message
  -p, --pause            Pause container during commit (default true)
```
If we want to run a container from our new image, we can do so using the docker run command.
``` bash 
$ docker run -it abdelhalim/apache2:webserver /bin/bash
root@232283cc1bd0:/# /etc/init.d/apache2 start 
 * Starting Apache httpd web server apache2                                                                                                           AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
 * 
root@232283cc1bd0:/# curl http://localhost
Hello Owasp Lab
root@232283cc1bd0:/# 
```

- Building images with a Dockerfile
    
    
We don't recommend the docker commit approach. Instead, we recommend that
you build images using a definition file called a Dockerfile and the docker build command

Creating a sample repository

``` bash 
$ mkdir web
$ cd web
$ vim  Dockerfile
# Version: 0.0.1
FROM ubuntu:16.04
MAINTAINER Souri Abdelhalim "abdelhalimsouri@gmail.com"
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Welcome to Owasp workshop 2018, from container' > /usr/share/nginx/html/index.html
EXPOSE 80
```
The Dockerfile contains a series of instructions paired with arguments. Each
instruction, for example FROM , should be in upper-case and be followed by an
argument: FROM ubuntu:14.04 . Instructions in the Dockerfile are processed from
the top down, so you should order them accordingly.


Let’s see what each of these lines in the Dockerfile do.


**FROM** specifies the base image to use as the starting point for this new image you’re creating. For this example we’re starting from ubuntu:16.04.

**MAINTAINER** The ``MAINTAINER`` instruction sets the Author field of the generated images

**EXPOSE** The ``EXPOSE`` instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified
    
**CMD** specifies what command to run when a container is started from the image. Notice that we can specify the command, as well as run-time arguments.

Each instruction adds a new layer to the image and then commits the image.

  
  Docker executing instructions roughly follow a workflow:

- Docker runs a container from the image.
- An instruction executes and makes a change to the container.
- Docker runs the equivalent of docker commit to commit a new layer.
- Docker then runs a new container from this new image.
- The next instruction in the file is executed, and the process repeats until all instructions have been executed.


Running the Dockerfile

```bash 
$ cd web
$ docker build -t="abdelhalim/static_web" .
Sending build context to Docker daemon   5.39MB
Step 1/6 : FROM ubuntu:16.04
 ---> 4a689991aa24
Step 2/6 : MAINTAINER Souri Abdelhalim "abdelhalimsouri@gmail.com"
 ---> Running in 42c27f0cf9e0
Removing intermediate container 42c27f0cf9e0
 ---> b854633b51b9
Step 3/6 : RUN apt-get update
 ---> Running in 38e2522a5e14
....
Removing intermediate container 38e2522a5e14
 ---> ae6d5b459b72
Step 4/6 : RUN apt-get install -y nginx
 ---> Running in 517277a8ae40
....
Removing intermediate container 517277a8ae40
 ---> 903f25aeba65
Step 5/6 : RUN echo 'Welcome to Owasp workshop 2018, from container' > /usr/share/nginx/html/index.html
 ---> Running in a3bd4c7bbbc3
Removing intermediate container a3bd4c7bbbc3
 ---> 69ddfa3530a3
Step 6/6 : EXPOSE 80
 ---> Running in 8d362ffbdd54
Removing intermediate container 8d362ffbdd54
 ---> fc069e50d128
Successfully built fc069e50d128
Successfully tagged abdelhalim/static_web:latest
```

Tagging a build 
``` bash 
$ docker build -t="abdelhalim/static_web:v1.0" .
Sending build context to Docker daemon   5.39MB
Step 1/6 : FROM ubuntu:16.04
 ---> 4a689991aa24
Step 2/6 : MAINTAINER Souri Abdelhalim "abdelhalimsouri@gmail.com"
 ---> Using cache
 ---> b854633b51b9
Step 3/6 : RUN apt-get update
 ---> Using cache
 ---> ae6d5b459b72
Step 4/6 : RUN apt-get install -y nginx
 ---> Using cache
 ---> 903f25aeba65
Step 5/6 : RUN echo 'Welcome to Owasp workshop 2018, from container' > /usr/share/nginx/html/index.html
 ---> Using cache
 ---> 69ddfa3530a3
Step 6/6 : EXPOSE 80
 ---> Using cache
 ---> fc069e50d128
Successfully built fc069e50d128
Successfully tagged abdelhalim/static_web:v1.0
```
>> TIP
If you don't specify any tag, Docker will automatically tag your image as
latest.

Build from URL path 
``` bash 
$ docker build -t="abdelhalim/static_web:version_web" https://raw.githubusercontent.com/etadata/owasp-lab/master/Dockerfile
Downloading build context from remote url: https://raw.githubusercontent.com/etadata/owasp-lab/master/Dockerfile     242B
Sending build context to Docker daemon  2.048kB
Step 1/6 : FROM ubuntu:16.04
 ---> 4a689991aa24
Step 2/6 : MAINTAINER Souri Abdelhalim "abdelhalimsouri@gmail.com"
 ---> Using cache
 ---> b854633b51b9
Step 3/6 : RUN apt-get update
 ---> Using cache
 ---> ae6d5b459b72
Step 4/6 : RUN apt-get install -y nginx
 ---> Using cache
 ---> 903f25aeba65
Step 5/6 : RUN echo 'Welcome to Owasp workshop 2018, from container' > /var/www/html/index.nginx-debian.html
 ---> Using cache
 ---> 69ddfa3530a3
Step 6/6 : EXPOSE 80
 ---> Using cache
 ---> fc069e50d128
Successfully built fc069e50d128
Successfully tagged abdelhalim/static_web:version_web
```

then check your container 
``` bash 
$ docker run -d -p 8888:80 abdelhalim/static_web:version_web nginx -g "daemon off;"
e6e7dc2b54b00984a39aed4e17ce243369c610ec537ba5ce3cda358c32902fdc
nordo@H-1:~/owasp-workshop$ curl http://localhost:8888
Welcome to Owasp workshop 2018, from container

```
This will bind port 80 on the container to port 8888 on the local host
Viewing the Docker port mapping 
``` bash 
$ docker ps -l
CONTAINER ID        IMAGE                               COMMAND                  CREATED              STATUS              PORTS                  NAMES
e6e7dc2b54b0        abdelhalim/static_web:version_web   "nginx -g 'daemon of…"   About a minute ago   Up About a minute   0.0.0.0:8888->80/tcp   distracted_bhabha
```

More details about the port mapping : https://docs.docker.com/network/links/#connect-using-network-port-mapping

Some useful commands of docker build 
``` bash 
$ docker build -h 
Flag shorthand -h has been deprecated, please use --help

Usage:	docker build [OPTIONS] PATH | URL | -

Build an image from a Dockerfile

Options:
      --add-host list           Add a custom host-to-IP mapping (host:ip)
      --build-arg list          Set build-time variables
      --cache-from strings      Images to consider as cache sources
      --cgroup-parent string    Optional parent cgroup for the container
      --compress                Compress the build context using gzip
      --cpu-period int          Limit the CPU CFS (Completely Fair Scheduler) period
      --cpu-quota int           Limit the CPU CFS (Completely Fair Scheduler) quota
  -c, --cpu-shares int          CPU shares (relative weight)
      --cpuset-cpus string      CPUs in which to allow execution (0-3, 0,1)
      --cpuset-mems string      MEMs in which to allow execution (0-3, 0,1)
      --disable-content-trust   Skip image verification (default true)
  -f, --file string             Name of the Dockerfile (Default is 'PATH/Dockerfile')
      --force-rm                Always remove intermediate containers
      --iidfile string          Write the image ID to the file
      --isolation string        Container isolation technology
      --label list              Set metadata for an image
  -m, --memory bytes            Memory limit
      --memory-swap bytes       Swap limit equal to memory plus swap: '-1' to enable unlimited swap
      --network string          Set the networking mode for the RUN instructions during build (default "default")
      --no-cache                Do not use cache when building the image
      --pull                    Always attempt to pull a newer version of the image
  -q, --quiet                   Suppress the build output and print image ID on success
      --rm                      Remove intermediate containers after a successful build (default true)
      --security-opt strings    Security options
      --shm-size bytes          Size of /dev/shm
  -t, --tag list                Name and optionally a tag in the 'name:tag' format
      --target string           Set the target build stage to build.
      --ulimit ulimit           Ulimit options (default [])
```
More details see : https://docs.docker.com/engine/reference/builder/#environment-replacement

 - Launching a container from our new image

``` bash 
$ sudo docker run -d -p 8880:80 --name static_web  abdelhalim/static_web  nginx -g "daemon off;"
e0ef24659994855ab6483b4106d35c68049d289d3de0d167ab308d65e84c13fb
nordo@H-1:~/owasp-workshop$ netstat  -antpl | grep 8880
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp6       0      0 :::8880                 :::*                    LISTEN      -               
nordo@H-1:~/owasp-workshop$ curl http://localhost:8880
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```
> we didn't see our hello message  "Welcome to Owasp workshop 2018, from container" in the home page because the default path of nginx is ``/var/www/html/index.nginx-debian.html`` and not ``/usr/share/nginx/html/index.html``


- Dockerfile instructions

https://docs.docker.com/engine/reference/builder/

- Pushing images to the Docker Hub

Once we've got an image, we can upload it to the Docker Hub. This allows us to
make it available for others to use.

Pushing a Docker Image
``` bash
$ docker push abdelhalim/static_web
The push refers to repository [docker.io/abdelhalim/static_web]
6292cd4228b1: Pushed 
ba47179f9939: Pushing [==============>                                    ]  16.01MB/56.54MB
76797f089262: Pushing [===================>                               ]  9.396MB/24.46MB
f1dfa8049aa6: Pushed 
79109c0f8a0b: Pushed 
33db8ccd260b: Mounted from library/ubuntu 
b8c891f0ffec: Mounted from library/ubuntu 
...
```
We've pushed our container to the docker hub Repo.
We can now see our uploaded image on the Docker Hub https://hub.docker.com/r/abdelhalim/static_web/.

>> TIP
You can find documentation and more information on the features of the
Docker Hub : https://docs.docker.com/docker-hub/

- Deleting an image

We can also delete images when we don't need them anymore. To do this, we'll
use the docker rmi command.

Deleting a Docker image:
``` bash
$ docker rmi abdelhalim/static_web
Untagged: abdelhalim/static_web:latest
....
....
```
>> NOTE
This only deletes the image locally. If you've previously pushed that
image to the Docker Hub, it'll still exist there.

Deleting multiple Docker images
``` bash 
docker rmi abdelhalim/apache abdelhalim/static_web
```
Deleting all images
``` bash 
docker rmi `docker images -a -q`
```

- Running your own Docker registry

Obviously, having a public registry of Docker images is highly useful. Sometimes,
however, we are going to want to build and store images that contain information
or data that we don't want to make public. There are two choices in this situation:

    -  Make use of private repositories on the Docker Hub.(https://registry.hub.docker.com/plans/)
    -  Run your own registry behind the firewall.

> NOTE
The registry does not currently have a user interface and is only made
available as an API server.

    - Running a registry from a container
Installing a registry from a Docker container is very simple. Just run the Docker-
provided container like so

    ``` bash
    $ docker run -d -p 5000:5000 --restart=always registry:2.2
    ```
We are also introducing

>> the ``--restart=always`` flag for that as in the event of something happening to the
>> container, it will restart and be available to serve out or accept images.




Listing the abdelhalim static_web Docker image:
    
``` bash 
$ docker images abdelhalim/static_web
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
abdelhalim/static_web   version_web         35ca00e89f00        34 minutes ago      197MB
abdelhalim/static_web   v1.0                fc069e50d128        About an hour ago   197MB
```

Next we take our image ID, fc069e50d128 , and tag it for our new registry. To
specify the new registry destination, we prefix the image name with the hostname
and port of our new registry. In our case, our new registry has a hostname of
reg.owasp.ma .

Modify your dns if you don't have a dns server 
``` bash
echo "127.0.0.1     reg.owasp.ma" >> /etc/hosts
```
Tagging ur image for our new registry
``` bash 
$ docker tag fc069e50d128 reg.owasp.ma:5000/abdelhalim/static_web
```
After tagging our image, we can then push it to the new registry using the ``docker push`` command:


Now it is time to put some images up on your new registry. The first thing we need
is an image to push to the registry.


``` bash 
$ docker push  reg.owasp.ma:5000/abdelhalim/static_web
The push refers to repository [reg.owasp.ma:5000/abdelhalim/static_web]
6292cd4228b1: Pushed 
ba47179f9939: Pushed 
76797f089262: Pushed 
f1dfa8049aa6: Pushed 
79109c0f8a0b: Pushed 
33db8ccd260b: Pushed 
b8c891f0ffec: Pushed 
latest: digest: sha256:fe23f948fdc022bf3dfdf17fe592ff7413cdc32750ece48a48362ee42eba10a4 size: 7643

```
The image is then posted in the local registry and available for us to build new
containers using the docker run command.

Builing a container from our local registry
``` bash 
$ docker run -it reg.owasp.ma:5000/abdelhalim/static_web /bin/bash
root@0606e51b6eb6:/# 
```
   - Alternatives

        - Quay
        - JFROG https://jfrog.com/
        - Private Docker Registry : https://private-docker-registry.com/
        - CoreOS Enterprise Registry :https://coreos.com/products/enterprise-registry/
        - Google Container Registry
        - Docker Trusted Registry



###### Container Management

- start  || stop || restart 
``` bash 
docker stop <container-id> 
docker start <container-id> 
docker restart <container-id> 
```

###### Analyzes resource usage and performance characteristics of running containers : Cadvisor
**cAdvisor** (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers.
It is a running daemon that collects, aggregates, processes, and exports information about running containers. Specifically, for each container it keeps
resource isolation parameters, historical resource usage, histograms of complete historical resource usage and network statistics. 
This data is exported by container and machine-wide.

###### Running cAdvisor in a Docker Container
```bash
 docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
```
  >> More info about cadvisor ==> [here](https://github.com/google/cadvisor)

### Docker Management :

``` bash 

Management Commands:
  checkpoint  Manage checkpoints
  config      Manage Docker configs
  container   Manage containers
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes
  ```
Get some information about the usage ressources

``` bash 
$ docker -H tcp://192.168.1.12:2375  system df 

TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
Images              26                  3                   7.955GB             6.336GB (79%)
Containers          10                  1                   2.513MB             1.245MB (49%)
Local Volumes       51                  5                   830.1MB             830MB (99%)
Build Cache                                                 0B                  0B
```


  
#### Gui Container 
##### 1. Portainer
###### running with Disable authentication
To disable Portainer internal authentication mechanism, start Portainer with the ``--no-auth`` flag:


``` bash 
$ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer --no-auth --logo "https://www.nplusone.ma/wp-content/uploads/2015/04/logonplusone1.png" 
```


###### Admin password
store the plaintext password inside a file and use the ``--admin-password-file`` flag:

``` bash
# mypassword is plaintext here
$ echo -n mypassword > /tmp/portainer_password
$ docker run -d -p 9002:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/portainer_password:/tmp/portainer_password   portainer/portainer --logo "https://www.nplusone.ma/wp-content/uploads/2015/04/logonplusone1.png" --admin-password-file /tmp/portainer_password 
```
you will see your container has been created 
``` bash
578a9732ed0a985718d437ac41d76b441090d58be6e6d05f26f39a9e3c4034fd
```


For more Info : see https://portainer.io/install.html
https://portainer.readthedocs.io/en/stable/configuration.html

##### 2. KiteMatic : **Visual Docker Container Management on Mac & Windows **
  
  **KiteMatic**  is a legacy solution, bundled with Docker Toolbox. We recommend updating to **Docker for Mac** or **Docker for Windows** if your
  system meets the requirements for one of those applications.
  
  >> More Info : [Kitematic](https://kitematic.com/)
