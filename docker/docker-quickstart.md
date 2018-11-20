first and foremost you need to install the docker engine to be able to follow this lab, and for this purpose you have two options either:

1. Install the docker on your machine
2. Download a VM with a preinstalled docker

## 1. Install the docker on your machine
You can dowload the VM from this repo which is already configured 
or you can do the following steps to install docker into your machine
>> this walkthrouth is for ubuntu 16.04
>> if you are using another OS please follow the steps mentionned in the official [doc](https://docs.docker.com/install/#supported-platforms)



1- Update the apt package index:
```bash
$ sudo apt-get update
```
2-  Install packages to allow apt to use a repository over HTTPS:
```bash
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```
3- Add Docker’s official GPG key:

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
Verify that you now have the key with the fingerprint ``9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88``, by searching for the last 8 characters of the fingerprint.
```bash
$ sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```
4- Add the stable repository 
```bash
sudo add-apt-repository deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
5- Install docker
```bash
$sudo apt-get update && sudo apt-get install docker-ce
```

## 2. Download a VM with a preinstalled docker
You can download a VM with a preinstalled docker from [here](https://mega.nz/#!ZQggUYzS!w667KoG7HsUHynPkGnW48NhnG2gPOCyD2WowhSPz8nk) 


Credentials:

- Login : owasp
- Password : owasp
## Quickstart

### starting stopping a docker daemon
```bash
$ sudo service docker start|restart|stop
```
### Configure where the Docker daemon listens for connections
By default, the Docker daemon listens for connections on a UNIX socket to accept requests from local clients.
It is possible to allow Docker to accept requests from remote hosts by configuring it to listen on an IP address and port as well as the UNIX socket
we will see how we can use the two ways
#### 1- using a  socket 
 By default, the docker daemon will use the unix socket ``unix:///var/run/docker.sock``
 (you can check this is the case for you by doing a sudo netstat -tunlp and note that there is no docker daemon process listening on any ports).
 It's recommended to keep this setting for security reasons but it sounds like Riak requires the daemon to be running on a TCP socket.

get the docker info
```bash
# docker info 
Containers: 10
 Running: 10
 Paused: 0
 Stopped: 0
Images: 7
Server Version: 17.03.2-ce
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 33
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins: 
 Volume: local
 Network: bridge host macvlan null overlay
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 4ab9917febca54791c5f071a9d1f404867857fcc
runc version: 54296cf40ad8143b62dbcaa1d90e520a2136ddfe
init version: N/A (expected: 949e6facb77383876aeff8a6944dde66b3089574)
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.4.0-131-generic
Operating System: Ubuntu 16.04.5 LTS
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 992.2 MiB
Name: node-master
ID: WGVL:VBSR:R52W:A2CL:XMCH:3SMP:LGNW:EFAQ:SI4Q:QAAT:SC75:GU6N
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false
```
#### 2- Using the TCP connection

on the server execute the command :
```bash
sudo docker -H 0.0.0.0:2375 -d &
```
>> **Warning**: This means machines that can talk to the daemon through that TCP socket can get root access to your host machine.

on the client  machine you can access the docker daemon by using 
```bash
# docker -H tcp://<ip> info 
Containers: 10
 Running: 10
 Paused: 0
 Stopped: 0
Images: 7
Server Version: 17.03.2-ce
Storage Driver: aufs
 Root Dir: /var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 33
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins: 
 Volume: local
 Network: bridge host macvlan null overlay
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 4ab9917febca54791c5f071a9d1f404867857fcc
runc version: 54296cf40ad8143b62dbcaa1d90e520a2136ddfe
...
Live Restore Enabled: false
```
>> use export DOCKER_HOST="tcp://<server-ip>:2375" to avvoid usig -H tcp: tcp://<ip>  each time you send a request
