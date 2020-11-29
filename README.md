# owasp-workshop: Orchestraing containers with Kubernetes

This repo contains Docker and kubernetes labs.

##### [Presentation of the lab](https://github.com/etadata/owasp-workshop/blob/master/Container%20Orchestration%20with%20Kubernetes.pdf)
### Prerequisite knowledge
- Experience using the Linux command line
- A basic understanding of containers (useful but not required)
- No Kubernetes experience required
- A working knowledge of Linux (e.g., shells, SSH, and package managers)
- A basic understanding of web servers, particularly how they typically communicate, IPs, and ports

### What you'll learn
- Learn how to use Kubernetes in production
- How to create/modify/intercate with container images
- Docker Client and Server running In Single or Distributed mode
- Build and publish your own custom images.
- Scanning your Image container
- Build your own penetration testing lab
- Provision a complete Kubernetes cluster using Google Kubernetes Engine
- Gain basic understanding of Kubernetes Fundamentals
- Deploy and manage Docker containers using kubectl
- Setup ReplicaSets, Services and Deployments on Kubernetes
- Deploy Applications on Kubernetes
- Get started using Kubernetes in development and production
 

### Materials or downloads needed in advance
In this workshop we will divide the lab into two parts:

 1.    Part 1 : Docker
 2.    Part 2 : Kubernetes

for the part1 of this workshop you have to either:

- Download a preconfigured VM from [here](https://mega.nz/#!ZQggUYzS!w667KoG7HsUHynPkGnW48NhnG2gPOCyD2WowhSPz8nk)
- Install the docker in your machine [How to do it](docker/docker-quickstart.md)
- clone [this repository](https://github.com/etadata/owasp-workshop) to get the sources : Optional

for the part 2 of this lab :  you need to create an account on **``google cloud``** or using your machine to to create a kubernetes cluster.

> [more details about the two options](kubernetes/bring-up.md).

### Description 
In this Workshop, we will dive in containers and see Docker in action. We will run our first containers, create our own images, and learn essential concepts along the way.

This workshop is relevant for both developers and sysadmins,security professionals,evryone eager to learn new stuff. 
If you have heard about Docker, containers and kubernetes, but haven't much (or any!) experience yet, this will get you started with a fast-paced.

## Outline

### Part 1 : Docker
#### [Bring-UP](docker/docker-quickstart.md) 
#### [docker-part-1](docker/docker-part1.md)
#### [docker-part-2](docker/docker-part2.md)
#### [Penetration Lab](docker/docker-penetest-lab.md)
### Part 2 : Kubernetes
#### [Bring-UP](kubernetes/bring-up.md)
#### [Kubernetes-part-1](kubernetes/pods.md)
#### [Kubernetes-part-2](kubernetes/tag-labels.md)
#### [Kubernetes-part-3](kubernetes/deployments.md)
#### [Kubernetes-part-4](kubernetes/services.md)
