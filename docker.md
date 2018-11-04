### Prerequisite knowledge
- Experience using the Linux command line
- A basic understanding of containers (useful but not required)
- No Kubernetes experience required
- Experience using the terminal or command prompts
- A working knowledge of Linux (e.g., shells, SSH, and package managers)
- A basic understanding of web and database servers, particularly how they typically communicate, IPs, and ports
- Basic familiarity with the Linux command-line
    Applicable to all programming languages and frameworks
- No prior knowledge of containers is necessary
- You don't need to pre-install Docker for this course


### What you'll learn
- Learn how to use Kubernetes in production
- hdh sjjs
- ns ddb ef"f e fe

### Materials or downloads needed in advance
- item 1 
- item 2 
- item 3

### Description 
It is a truth universally acknowledged that a techie in possession of any production code whatsoever must be in want of a container orchestration platform. What’s up for debate, according to noted thought leader Jane Austen, is how many pizzas the team is going to eat.

In this hands-on Kubernetes workshop, Bridget Kromhout guides you through an interactive look at all the moving parts you need to know about to use Kubernetes in production. If you’re into dev or ops or some portmanteau thereof, this is relevant to your interests.


In this hands-on tutorial, we will dive in containers and see Docker in action. We will run our first containers, create our own images, connect multiple services together to form complex stacks, learn best practices to write Dockerfiles, and learn essential concepts along the way.

This tutorial is relevant for both developers and sysadmins. If you have heard about Docker and containers, but haven't much (or any!) experience yet, this will get you started with a fast-paced, hands-on introduction.

No previous knowledge of Docker or containers is required, but you will need some basic UNIX command-line skills. It is recommended that you know how to use a UNIX editor (like vi or emacs). You won't need to pre-install Docker before the course: each student will be given credentials to connect to an individual virtual machine. So all you need is a computer with a SSH client!




#### Souri Abdelhalim
blavllalalza  zfkhkeahfkef ef
efkef ekf ef ehfkehf e ffehfo e



### Running trainings site


Clone this repo and run docker-compose up from the root directory of the repo. Browse the site by visiting http://localhost:4000
Alternately, clone the repo and run the following docker container: docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll -it -p 4000:4000 jekyll/jekyll:3.2 jekyll serve

Browse the site by visiting http://localhost:4000


# Outline


## Introducing Containers 


## Installing and Updating Docker


###### Centos / RedHat

###### Debian/Ubuntu

###### Install and Update Docker

###### Configuration 
###### Client-Server

###### Run a background MySQL container
Background containers are how you’ll run most applications. Here’s a simple example using MySQL.
1. Run a new MySQL container with the following command.


   ``docker container run --detach --name mydb 
 -e MYSQL_ROOT_PASSWORD=my-secret-pw \
 mysql:latest
``

- --detach will run the container in the background.
- --name will name it mydb.
- -e will use an environment variable to specify the root password (NOTE: This should never be done in production).
  
2. List the running containers.

``docker container ls ``
OR
`` docker ps ``

3. You can check what’s happening in your containers by using a couple of built-in Docker commands: docker container logs and docker container top.

``docker container logs <container>``

## Major Docker Components

##### Outile 
###### Docker Engine
###### Images
###### Containers
###### Registries and Repositories




###### Working with Docker images and repositories

the docker book


- Listing Docker images

- Pulling images

- Searching for images

- Building our own images

- Using Docker commit to create images

- Building images with a Dockerfile
    - Our first Dockerfile
    - ```# Version: 0.0.1
FROM ubuntu:14.04
MAINTAINER James Turnbull "james@example.com"
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Hi, I am in your container' \
>/usr/share/nginx/html/index.html
EXPOSE 80```
- Dockerfiles and the build cache
- Viewing our new image
- - Launching a container from our new image


- Dockerfile instructions

- Running your own Docker registry
    - Running a registry from a container
    - ```Listing 4.76: Running a container-based registry
$ sudo docker run -p 5000:5000 registry```

``` $ docker run -d -p 5000:5000 --restart=always registry:2.2 ```
We are also introducing

>> the ``--restart=always`` flag for that as in the event of something happening to the
>> container, it will restart and be available to serve out or accept images.

Now it is time to put some images up on your new registry. The first thing we need
is an image to push to the registry and we can do that in two ways. We can build
images based on Docker files that we have created or we can pull down an image
from another registry, in our case we will be using the Docker Hub, and then push
that image to our new registry server. First, we need an image to choose and again,
we will default back to the mysql image since it's a more popular image that most
people might be using in their environments at some point along the way.

``` docker pull <image-name> ...... all the content here```

Next, you need to tag the image so it will now be pointing to your new registry so
you can do push it to the new location:

``` $ docker tag mysql <IP_address>:5000/mysql ```
    - Testing the new registry
    - Alternatives

## A Closer Look at Images and Containers




Now, let's assume we made a customization to the image. Let's say that we set up the
container to ship its logs off to a log stash server that we are using to collect our logs
from all our containers that we are running. We now need to save those changes.


``` $ docker commit be4ea9a7734e <dns.name>/mysql ```


## Container Management
#### OutLine

###### Container Management

https://github.com/docker/labs/blob/master/slides/docker-introduction.pdf page 22

- start  || stop || restart 

One process per Container


We can run multiple processes per Container

- docker	attach	
    - Attaches to PID 1 inside the container
    - In the real world, PID 1 inside a container will probably not be a
shell
- ssh 
    - Docker Tips : access the Docker daemon via ssh
    - https://medium.com/lucjuggery/docker-tips-access-the-docker-daemon-via-ssh-97cd6b44a53?mkt_tok=eyJpIjoiTWpBMU1EQXhObUZqTXpaaSIsInQiOiJcL05UbTVjaWdOMlJHNnBDZjRKakpDUWZMNVwvdk9xRktyMzczSGtjRFRyQWc4K3FiM3VGTWF4cmloN1BJT2dGbzgweDJ1Q0ZPSVJNNjZzS095bTBFNkZ1M01DamFOV3pSYWhEdXo0UUh5c013V1VtckdOSmdtb2J3VUVwcWo3Z1FtIn0%3D
    - 
- nsenter	
    - Looking to start a shell inside a Docker container?
    - What is nsenter?
        - It is a small tool allowing to enter into namespaces. Technically, it can enter existing namespaces, or spawn a process into a new set of namespaces. "What are those namespaces you're blabbering about?" We are talking about container namespaces.
        - nsenter can do many useful things, but the main reason why I'm so excited about it is because it lets you enter into a Docker container.
    -  Allows us to enter Namespaces
    - Requires the containers PID (get from “docker	inspect”)
    - https://github.com/jpetazzo/nsenter

- Removing Containers
- docker inspect
  
#### Gui Container : Portainer
###### running with Disable authentication
To disable Portainer internal authentication mechanism, start Portainer with the ``--no-auth`` flag:


```$ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer --no-auth --logo "https://www.nplusone.ma/wp-content/uploads/2015/04/logonplusone1.png" ```


###### Admin password
store the plaintext password inside a file and use the ``--admin-password-file`` flag:

``` bash
# mypassword is plaintext here
$ echo -n mypassword > /tmp/portainer_password
$ docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/portainer_password:/tmp/portainer_password portainer/portainer --admin-password-file /tmp/portainer_password
```

docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer  -v /tmp/portainer_password:/tmp/portainer_password --logo "https://www.nplusone.ma/wp-content/uploads/2015/04/logonplusone1.png"

For more Info : see https://portainer.io/install.html
https://portainer.readthedocs.io/en/stable/configuration.html
###### Container Config
###### Look Inside Running Containers
###### Different Ways to Get Shell Access

## Building from a Dockerfile

#### OutLine
###### The Big Picture
###### Dockerfile Basics
###### Creating a Dockerfile
###### Building from a Dockerfile
###### The Build Cache
###### Dockerfile and Layers
###### Dockerfile Instructions
###### CMD, ENTRYPOINT, ENV, VOLUME



        Docerkfile
        FROM 123
        INSTRUCTION abc
        INSTRUCTION def
        INSTRUCTION ghi
        INSTRUCTION jkl


CMD
Run-time 
Run commands in
containers at launch time 
Equivalent of -
docker	run <args>	<command>	
  
docker	run <args>  /bin/bash	
  
RUN

Build-time
Add layers to images
Used to install apps

ENTRYPOINT

Can’t be overridden at run-time with normal commands –
docker	
  run	
  ...	
  <command>	
  
Any command at run-time is used as an argument to
ENTRYPOINT
Variable expansion etc...
1. Dockerfile Basics
2. Building Our Own Dockerfile
3. Viewing the Build


``` docker	build	 –t <image-­‐tag>	.	```
https://medium.com/lucjuggery/docker-tips-about-the-build-context-dbc76505e178## Working with Registries

## Diving Deeper with Dockerfile

https://github.com/docker/labs/blob/master/dockercon-us-2017/workshop-slides/docker-101-workshop-dockercon.pdf page 19

##### Build a simple website image
Let’s have a look at the Dockerfile we’ll be using, which builds a simple website that allows you to send a tweet.

1. Display the contents of the Dockerfile.
   `` cat Dockerfile ``
and here is the content of the Dockerfile
> ``FROM nginx:latest
> COPY index.html /usr/share/nginx/html
>  COPY linux.png /usr/share/nginx/html
>  EXPOSE 80 443     
>  CMD ["nginx", "-g", "daemon off;"]``

Let’s see what each of these lines in the Dockerfile do.


    **FROM** specifies the base image to use as the starting point for this new image you’re creating. For this example we’re starting from nginx:latest.
    COPY copies files from the Docker host into the image, at a known location. In this example, COPY is used to copy two files into the image: index.html. and a graphic that will be used on our webpage.
    EXPOSE documents which ports the application uses.
    CMD specifies what command to run when a container is started from the image. Notice that we can specify the command, as well as run-time arguments.


## Docker Networking

#### OutLine
- Network drivers and basics
- Naming and inspecting
- Service discovery with DNS
- Legacy links

- The “docker0” Virtual Bridge
- Virtual Ethernet Interfaces
- Exposing Ports
- Linking Containers

https://github.com/docker/labs/blob/master/slides/docker-networking.pdf


# Docker Networking Basics

# Lab Meta

> **Difficulty**: Beginner

> **Time**: Approximately 10 minutes

In this lab you'll look at the most basic networking components that come with a fresh installation of Docker.

You will complete the following steps as part of this lab.

- [Step 1 - The `docker network` command](#docker_network)
- [Step 2 - List networks](#list_networks)
- [Step 3 - Inspect a network](#inspect)
- [Step 4 - List network driver plugins](#list_drivers)

# Prerequisites

You will need all of the following to complete this lab:

- A Linux-based Docker Host running Docker 1.12 or higher

# <a name="docker_network"></a>Step 1: The `docker network` command

The `docker network` command is the main command for configuring and managing container networks.

Run a simple `docker network` command from any of your lab machines.

```
$ docker network

Usage:  docker network COMMAND

Manage Docker networks

Options:
      --help   Print usage

Commands:
  connect     Connect a container to a network
  create      Create a network
  disconnect  Disconnect a container from a network
  inspect     Display detailed information on one or more networks
  ls          List networks
  rm          Remove one or more networks

Run 'docker network COMMAND --help' for more information on a command.
```

The command output shows how to use the command as well as all of the `docker network` sub-commands. As you can see from the output, the `docker network` command allows you to create new networks, list existing networks, inspect networks, and remove networks. It also allows you to connect and disconnect containers from networks.

# <a name="list_networks"></a>Step 2: List networks

Run a `docker network ls` command to view existing container networks on the current Docker host.

```
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
1befe23acd58        bridge              bridge              local
726ead8f4e6b        host                host                local
ef4896538cc7        none                null                local
```

The output above shows the container networks that are created as part of a standard installation of Docker.

New networks that you create will also show up in the output of the `docker network ls` command.

You can see that each network gets a unique `ID` and `NAME`. Each network is also associated with a single driver. Notice that the "bridge" network and the "host" network have the same name as their respective drivers.

# <a name="inspect"></a>Step 3: Inspect a network

The `docker network inspect` command is used to view network configuration details. These details include; name, ID, driver, IPAM driver, subnet info, connected containers, and more.

Use `docker network inspect` to view configuration details of the container networks on your Docker host. The command below shows the details of the network called `bridge`.

```
$ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "1befe23acd58cbda7290c45f6d1f5c37a3b43de645d48de6c1ffebd985c8af4b",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```

> **NOTE:** The syntax of the `docker network inspect` command is `docker network inspect <network>`, where `<network>` can be either network name or network ID. In the example above we are showing the configuration details for the network called "bridge". Do not confuse this with the "bridge" driver.


# <a name="list_drivers"></a>Step 4: List network driver plugins

The `docker info` command shows a lot of interesting information about a Docker installation.

Run a `docker info` command on any of your Docker hosts and locate the list of network plugins.

```
$ docker info
Containers: 0
 Running: 0
 Paused: 0
 Stopped: 0
Images: 0
Server Version: 1.12.3
Storage Driver: aufs
<Snip>
Plugins:
 Volume: local
 Network: bridge host null overlay    <<<<<<<<
Swarm: inactive
Runtimes: runc
<Snip>
```

The output above shows the **bridge**, **host**, **null**, and **overlay** drivers.

### Docker Compose
- Local development workflow
- Creating dev stacks
- Advanced Dockerfiles
- Using volumes locally


Docker Compose is a tool for defining and running multi-container Docker applications. It  is an amazing developer tool to create the development environment for your application stack. It allows you to define each component of your application following a clear and simple syntax in YAML files. It works in all environments: production, staging, development, testing, as well as CI workflows. Though Compose files are easy to describe a set of related services but there are couple of problems which has emerged in the past. One of the major concern has been around multiple environments to deploy the application with small configuration differences.

http://collabnix.com/category/docker/docker-compose/




## Troubleshooting
#### OutLine
- Docker Daemon Logging
- Container Logging
- Troubleshooting Images
- Network Troubleshooting



### containers Juiceshop / DVMA
