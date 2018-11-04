






Heading level 1
* ===============

> Dorothy followed her through many of the beautiful rooms in her castle.



Blockquote with multiple paragraph

> Dorothy followed her through many of the beautiful rooms in her castle.
>
> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.


Nested blockquote
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

Blockquotes with Other Elements

Blockquotes can contain other Markdown formatted elements. Not all elements can be used — you’ll need to experiment to see which ones work.

> #### The quarterly results look great!
>
> - Revenue was off the chart.
> - Profits were higher than ever.
>
>  *Everything* is going according to **plan**.

1. First item
2. Second item
3. Third item
4. Fourth item 


Paragraphs

*   This is the first list item.
*   Here's the second list item.

    I need to add another paragraph below the second list item.

*   And here's the third list item.


Code 

    <html>
      <head>
      </head>
    </html>


``Use `code` in your Markdown file.``


Adding titles

My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").


Images:

[![An old rock in the desert](/assets/images/shiprock.jpg "Shiprock, New Mexico by Beau Rogers")](https://www.flickr.com/photos/beaurogers/31833779864/in/photolist-Qv3rFw-34mt9F-a9Cmfy-5Ha3Zi-9msKdv-o3hgjr-hWpUte-4WMsJ1-KUQ8N-deshUb-vssBD-6CQci6-8AFCiD-zsJWT-nNfsgB-dPDwZJ-bn9JGn-5HtSXY-6CUhAL-a4UTXB-ugPum-KUPSo-fBLNm-6CUmpy-4WMsc9-8a7D3T-83KJev-6CQ2bK-nNusHJ-a78rQH-nw3NvT-7aq2qf-8wwBso-3nNceh-ugSKP-4mh4kh-bbeeqH-a7biME-q3PtTf-brFpgb-cg38zw-bXMZc-nJPELD-f58Lmo-bXMYG-bz8AAi-bxNtNT-bXMYi-bXMY6-bXMYv)


term
: definition
Strikethrough 	~~The world is flat.~~
Task List 	- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media 
- 

## Architecture 

### diagram  - High Level

the design will be here with a simpler way 
# Installation
Master
Packages
•	 ntpd
•	 etcd
•	 kubernetes

Minions/Nodes
Packages
•	 ntpd
•	 etcd
•	 kubernetes
•	 docker
Configuration Files
/etc/kubernetes/config
```
# Comma separated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS=”--etcd-servers=http://centos-master:2379”
# logging to stderr means we get it in the systemd journal
KUBE_LOGTOSTDERR=”--logtostderr=true”
# journal message level, 0 is debug
KUBE_LOG_LEVEL=”--v=0”
# Should this cluster be allowed to run privileged docker containers
KUBE_ALLOW_PRIV=”--allow-privileged=false”
# How the replication controller and scheduler find the kube-apiserver
KUBE_MASTER=”--master=http://centos-master:8080”
### define all the spets required to well install the kubertetes compenents whichever on Linux/Centos Or Linux /Ubuntu
```
/etc/etcd/etcd.conf
```# [member]
ETCD_NAME=default
ETCD_DATA_DIR=”/var/lib/etcd/default.etcd”
ETCD_LISTEN_CLIENT_URLS=”http://0.0.0.0:2379”
# [cluster]
ETCD_ADVERTISE_CLIENT_URLS=”http://0.0.0.0:2379”
```

/etc/kubernetes/apiserver
```
# The address on the local server to listen to.
KUBE_API_ADDRESS=”--address=0.0.0.0”
# The port on the local server to listen on.
KUBE_API_PORT=”--port=8080”
# Port kubelets listen on
KUBELET_PORT=”--kubelet-port=10250”
# Address range to use for services
KUBE_SERVICE_ADDRESSES=”--service-cluster-ip-range=10.254.0.0/16”
# Add your own!
KUBE_API_ARGS=””
```
Enable and Start Required Services
•	
systemctl enable/start
» » ntpd
» » etcd
» » kube-apiserver
» » kube-controller-manager
» » kube-scheduler
>>The master controller needs to be running before nodes are started and attempt to register

# Minions/Nodes

#### Configuration Files

/etc/kubernetes/config
``` 
# Comma separated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS=”--etcd-servers=http://centos-master:2379”
# logging to stderr means we get it in the systemd journal
KUBE_LOGTOSTDERR=”--logtostderr=true”
# journal message level, 0 is debug
KUBE_LOG_LEVEL=”--v=0”
# Should this cluster be allowed to run privileged docker containers
KUBE_ALLOW_PRIV=”--allow-privileged=false”
# How the replication controller and scheduler find the kube-apiserver
KUBE_MASTER=”--master=http://centos-master:8080”
```
/etc/kubernetes/kubelet
```
# The address for the info server to serve on
KUBELET_ADDRESS=”--address=0.0.0.0”
# The port for the info server to serve on
KUBELET_PORT=”--port=10250”
# You may leave this blank to use the actual hostname
KUBELET_HOSTNAME=”--hostname-override=centos-minion1”
# Location of the api-server
KUBELET_API_SERVER=”--api-servers=http://centos-master:8080”
# Add your own!
KUBELET_ARGS=”” 
```
Enable and Start Required Services

•	
systemctl enable/start
> -  ntpd
> - kube-proxy
> -  kubelet
> -  docker
>>The master controller needs to be running before nodes are started or attempt to register
# Creating Pods
##### Creating pods from YAML or JSON descriptors
###### Examining a YAML descriptor of an existing pod


###### Creating a simple YAML descriptor for a pod

page 63

###### Using kubectl create to create the pod

###### Viewing application logs

###### Sending requests to the pod




### Organizing pods with labels

###### Specifying labels when creating a pod
###### Modifying labels of existing pods
###### Listing subsets of pods through label selectors 
###### Listing pods using a label selector
###### Using multiple conditions in a label selector




### Using namespaces to group resources

#### Discovering other namespaces and their pods
#### Creating a namespace
#### Managing objects in other namespaces
#### Understanding the isolation provided by namespaces
#### 


###   Stopping and removing pods
#### Deleting a pod by name
#### Deleting pods using label selectors
#### Deleting pods by deleting the whole namespace
#### Deleting all pods in a namespace, while keeping the namespace
#### Deleting (almost) all resources in a namespace
#### 

### Pod Definition

# Pod Definition

# kubectl - Function Listing





#### 01. Create and Deploy Pod Definitions

create pod from yaml file
``` yaml
hhhhzh
jhez

ezz
e
ze
z
e
z
```

``` kubectl get pods```

``` kubectl describe pod <nginx>```





Create a pod from a cmmand line 

```  kubectl run "type here the complete command" ```
access to pod service internally for expmle nginx or apache 
```wget -q0- http://172.20.20.1```


to expose the service 

generate random port to publish your service

```kubectl port-forwarder nginx :80```


then do
```wget -q0- http://localhost:<randomport>```

.....



>It's time for a quick knowledge check.

> Answer the following questions about the newly created pod.

>>  -  What is the IP address of the monolith Pod?
>>  -   What node is the monolith Pod running on?
>>  -  What containers are running in the monolith Pod?
>>  -   What are the labels attached to the monolith Pod?
>>  -   What arguments are set on the monolith container?

As you can see, Kubernetes makes it easy create pods by describing them in configuration files and view information about them when they are running. At this point you have the ability create all the pods your deployment requires!

#### 02. Tags, Labels and Selectors
nginx-label.yaml
```yaml


c
c
c
c
c
c
c
c
c
c
c
c

```
create the pod 
``` kubectl create -f nginx-label.yaml```

then try to get the pods 
``` kubectl get pods ```
filtring by labels

``` kubectl get pods --label app=<label-name>``` OR ``` kubectl get pods -l app=<label-name>```

get more info about the pod 

``` kubectl describe pods -l app=<label-name> ```



Run the following command to set up port-forwarding:

```kubectl port-forward <monolith> 10080:80```

Now we can start talking to our pod using curl.

``` $ curl http://127.0.0.1:10080 ```

#### 03. Deployment State
A Deployment controller provides declarative updates for Pods and ReplicaSets.

You describe a desired state in a Deployment object, and the Deployment controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

 Deployments(http://kubernetes.io/docs/user-guide/deployments/#what-is-a-deployment) are a declarative way ensure that the number of Pods running is equal to the desired number of Pods, specified by the user.

create a prod-nginx.yaml file
nginx-deploy-prod.yaml
``` yaml

x
x
x
x
x
x
x
x
x
x
```
then deploy the pod
``` kubectl create -f nginx-deploy-prod.yaml```

``` kubectl get pods```
``` kubectl get deployments```

``` kubectl create -f nginx-dev-prod.yaml```

``` kubectl get pods```
``` kubectl get deployments```



``` kubectl describe deployments -l app=<> ```



dev-update 

nginx-deploy-dev-update.yaml

``` yaml
c
c
cc
c
c
c
c
```

```kubectl apply -f nginx-deploy-dev-update.yaml```

``` kubectl get pods  && kubect describe deployments  nginx-deploy-dev```



#### 04. Multi-Pod (Container) Replication Controller
vim nginx-multi-labels.yaml
``` yaml
v
v
v
v
v
v
v
v
v
v

v
v
v
v
v
v
```

``` kubectl get nodes ```
``` kubectl create -f ngiginx-multi-labels.yaml ```

``` kubectl describe replicationcontroller ```


``` kubectl describe replicationcontrollers ```

inside the node 
``` docker ps ```


``` kubectl get services ```


try to delete a pod 

``` kubectl delete pod <> ```

``` kubectl get pods ```
do this operation with multiple pods to ensure that everything  is OK

``` kubectl describe replicationcontrollers ```

Now delete replicationcontroller

``` kubectl delete replicationcontroller <name> ```

``` kubectl get pods ```

Nothing will be display 

#### 05. Create and Deploy Service Definitions

Pods aren't meant to be persistent. They can be stopped or started for many reasons -- like failed liveness or readiness checks -- and this leads to a problem:

What happens if we want to communicate with a set of Pods? When they get restarted they might have a different IP address.

That's where ``Services``(lien) come in.

A Kubernetes Service is an abstraction which defines a logical set of Pods and a policy by which to access them - sometimes called a micro-service. The set of Pods targeted by a Service is (usually) determined by a ``Label Selector`` (https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors).

If Pods have the correct labels, they are automatically picked up ap and exposed by our services.

The level of access a service provides to a set of pods depends on the Service's type. Currently there are three types:

1. ClusterIP (internal) -- the default type means that this Service is only visible inside of the cluster,

2. NodePort gives each node in the cluster an externally accessible IP and

3. LoadBalancer adds a load balancer from the cloud provider which forwards traffic from the service to Nodes within it.


Services provide stable endpoints for Pods


 create a service yaml file 
 vim nginx-service.yaml 
 ```yaml 
 x
 x
 x
 x
 xx
 xx
 xx

 x
 x
 x
 x
 x
 x
 ```

 execute 

 ``` kubectl create -f <file-service.yaml> ```

 get the services 

 ``` kubectl get services ```


get teh description of the service 
``` kubectl describe service <service> ```
output here 


```kubectl run ...... ```


delete a service 

``` kubectl delete service <>```



> it's time for a quick knowledge check.

> Use the following commands to answer the questions below.

> ```$ kubectl get services monolith ```

> ``` $ kubectl describe services monolith```

> Questions:

>> -   Why are you unable to get a response from the monolith service?
>> -  How many endpoints does the monolith service have?
>> -   What labels must a Pod have to be picked up by the monolith service?


## Logs, Scaling and Recovery


#### 01. Creating Temporary Pods at the Command line

``` kubectl run mysample --image=latest123/apache```


``` kubectl get pods && kubectl get deployments```

``` kubectl describe deployments ```


``` kubectl describe pod <name-ofthe-pod> ```

``` kubectl delete  deployment mysample ```
``` kubectl get  deployments ```


``` kubectl run myreplica --image=latest123/apache --replicas=2  --labels=app)myapache,version=1.0 ```


then describe 
``` kubectl describe pod <name-ofthe-pod> ```



#### 02. Interacting with Pod Containers

``` kubectl get ... ```

``` kubectl exec ...... ```

``` kubectl port-forward  ...  ```

As you can see, interacting with pods is as easy as using the kubectl command. If you need to hit a container remotely or get a login shell, ``Kubernetes`` provides everything you need to get up and going.
#### 03. Logs

``` kubectl logs ...```


detail and  describe clearly how to do a troubleshooting into kubernetes


#### 04. Autoscaling and Scaling our Pods


run pod in one single command line 

``` kuberctl run myautoscale --image=latest123/apache --port=80 --labels=app=myautoscale ```


``` kubectl get deployments ```

``` kubectl autoscale ....```


UP

``` kubectl scale --current-replicas=2  --replicas=4  deployments/myautoscale ```


DOWN 


``` kubectl scale --current-replicas=4  --replicas=2  deployments/myautoscale ```


#### 05. Failure and Recovery

stop the service kubelet kube-proxy docker on a minion 

``` kubect get nodes ```
``` kubect get pods ```


one the node will backuped, all the containers inside it will be recevered

# Viewing and Finding Resources


# Modifying and Deleting Resources


# Interacting with Existing/Running Pods



# Useful Commands