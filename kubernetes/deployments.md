#### Deployments

Deployments are intended to replace Replication Controllers.  They provide the same replication functions (through Replica Sets) and also the ability to rollout changes and roll them back if necessary.

>> A Deployment controller provides declarative updates for Pods and ReplicaSets.






my-server-deploymeny-prod.yaml
``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: my-server-prod-deployement
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: my-server-prod-deployement
    spec:
      containers:
      - name: my-server-prod-deployement
        image: nginx:1.15.4-alpine
        ports:
        -  containerPort: 80
```

my-server-deploymeny-uat.yaml

``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: my-server-uat-deployement
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: my-server-uat-deployement
    spec:
      containers:
      - name: my-server-uat-deployement
        image: nginx:1.15.4-alpine
        ports:
        -  containerPort: 80
```
then execute 
``` bash 
# kubectl create -f my-server-deploymeny-uat.yaml 
deployment.extensions/my-server-uat-deployement created
# kubectl create -f my-server-deploymeny-prod.yaml 
deployment.extensions/my-server-prod-deployement created
```

explain each line 
The template field contains the following sub-fields:

-  The Pods are labeled **app: my-server-uat-deployement** using the labels field.
    -  The Pod template’s specification, or .template.spec field, indicates that the Pods run one container, nginx, which runs the nginx Docker Hub image at version 1.15.4-alpine
    -   Create one container and name it nginx using the name field.
    -   Run the nginx image at version 1.15.4-alpine.
    -   Open port 80 so that the container can send and accept traffic.
-  the number of replicas is 3 ( will run 3 pods)


The replicas is the number of the pods which want to create to garante our HA
``` bash 
# kubectl  get pods
NAME                                          READY   STATUS    RESTARTS   AGE
mc1                                           2/2     Running   0          4h25m
my-server-dev                                 1/1     Running   0          51m
my-server-prod                                1/1     Running   0          51m
my-server-prod-deployement-779fb6bfdb-k7h2l   1/1     Running   0          11m
my-server-prod-deployement-779fb6bfdb-mq9t7   1/1     Running   0          11m
my-server-prod-deployement-779fb6bfdb-q9f42   1/1     Running   0          11m
my-server-uat                                 1/1     Running   0          51m
my-server-uat-deployement-6bd65dfd9c-cdkfl    1/1     Running   0          83s
my-server-uat-deployement-6bd65dfd9c-kvkdn    1/1     Running   0          79s
my-server-uat-deployement-6bd65dfd9c-lsqz7    1/1     Running   0          83s
```
As you can see we have 3 pods  of the my-server-prod-deployement with a unique ID

``` bash 
# # kubectl  get deployments 
NAME                         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
my-server-prod-deployement   3         3         3            3           2s
my-server-uat-deployement    3         3         3            3           10m

```
describe a deployment 
``` bash 
# kubectl  describe deployment my-server-uat-deployement 
Name:                   my-server-uat-deployement
Namespace:              default
CreationTimestamp:      Tue, 06 Nov 2018 19:55:13 +0000
Labels:                 app=my-server-uat-deployement
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=my-server-uat-deployement
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=my-server-uat-deployement
  Containers:
   my-server-uat-deployement:
    Image:        nginx:1.15.4-alpine
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
OldReplicaSets:  <none>
NewReplicaSet:   my-server-uat-deployement-78dc7d5b9d (3/3 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  2m    deployment-controller  Scaled up replica set my-server-uat-deployement-78dc7d5b9d to 3
```

selecting a deploymet by label 
``` bash 
# kubectl  describe deployments -l app=my-server-uat-deployement
Name:                   my-server-uat-deployement
Namespace:              default
CreationTimestamp:      Tue, 06 Nov 2018 19:55:13 +0000
Labels:                 app=my-server-uat-deployement
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=my-server-uat-deployement
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=my-server-uat-deployement
  Containers:
   my-server-uat-deployement:
    Image:        nginx:1.15.4-alpine
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
.....
```


delete a deployment 
``` bash 
# kubectl  delete deployment my-server-uat-deployement
```
delete multiple deploments 
``` bash 
# kubectl  delete deployments <dep1> [dep2] ...
```

By Using deployment type , we can do an update to any of the pods just by applying a deployment update to that specific pod


let's do an update for our web server from nginx:1.15.4-alpine to nginx:1.15.5-alpine

my-server-deploymeny-uat-update.yaml
``` yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: my-server-uat-deployement
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: my-server-uat-deployement
    spec:
      containers:
      - name: my-server-uat-deployement
        image: nginx:1.15.5-alpine
        ports:
        -  containerPort: 80
```

Now let's apply the update 
``` bash 
# kubectl  apply -f my-server-deploymeny-uat-update.yaml 
deployment.extensions/my-server-uat-deployement configured
```


let's see if the running image of nginx  is 1.15.5
``` bash 
# kubectl describe deployments my-server-uat-deployement
Name:                   my-server-uat-deployement
Namespace:              default
CreationTimestamp:      Tue, 06 Nov 2018 19:55:13 +0000
Labels:                 app=my-server-uat-deployement
Annotations:            deployment.kubernetes.io/revision: 2
                        kubectl.kubernetes.io/last-applied-configuration:
                          {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"name":"my-server-uat-deployement","namespace":"defaul...
Selector:               app=my-server-uat-deployement
Replicas:               3 desired | 3 updated | 3 total | 3 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surge
Pod Template:
  Labels:  app=my-server-uat-deployement
  Containers:
   my-server-uat-deployement:
    Image:        nginx:1.15.5-alpine
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
```
``` bash
# kubectl  get pods 
NAME                                          READY   STATUS    RESTARTS   AGE
mc1                                           2/2     Running   0          4h32m
my-server-dev                                 1/1     Running   0          58m
my-server-prod                                1/1     Running   0          58m
my-server-prod-deployement-779fb6bfdb-k7h2l   1/1     Running   0          17m
my-server-prod-deployement-779fb6bfdb-mq9t7   1/1     Running   0          17m
my-server-prod-deployement-779fb6bfdb-q9f42   1/1     Running   0          17m
my-server-uat                                 1/1     Running   0          58m
my-server-uat-deployement-6bd65dfd9c-cdkfl    1/1     Running   0          7m57s
my-server-uat-deployement-6bd65dfd9c-kvkdn    1/1     Running   0          7m53s
my-server-uat-deployement-6bd65dfd9c-lsqz7    1/1     Running   0          7m57s
root@node-master:~/deployment# ^C
root@node-master:~/deployment# kubectl  describe pod  my-server-uat-deployement-6bd65dfd9c-cdkfl
Name:               my-server-uat-deployement-6bd65dfd9c-cdkfl
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-2/10.132.0.3
....
```
then check the version running inside the pod
``` bash 
# kubectl exec my-server-uat-deployement-6bd65dfd9c-cdkfl  -- /usr/sbin/nginx -v
nginx version: nginx/1.15.5
```
##### Recovering from crashes: Creating a fixed number of replicas

Now that we know everything is running, let’s take a look at some replication use cases.

The first thing we think of when it comes to replication is recovering from crashes. If there are 5 (or 20, or 100) copies of an application running, and one or more crashes, it’s not a catastrophe.  Kubernetes improves the situation further by ensuring that if a pod goes down, it’s replaced

``` bash 
# kubectl  get pods 
NAME                                          READY   STATUS    RESTARTS   AGE
mc1                                           2/2     Running   0          4h52m
my-server-dev                                 1/1     Running   0          78m
my-server-prod                                1/1     Running   0          78m
my-server-prod-deployement-779fb6bfdb-k7h2l   1/1     Running   0          38m
my-server-prod-deployement-779fb6bfdb-mq9t7   1/1     Running   0          38m
my-server-prod-deployement-779fb6bfdb-q9f42   1/1     Running   0          38m
my-server-uat                                 1/1     Running   0          78m
my-server-uat-deployement-6bd65dfd9c-cdkfl    1/1     Running   0          28m
my-server-uat-deployement-6bd65dfd9c-kvkdn    1/1     Running   0          28m
my-server-uat-deployement-6bd65dfd9c-lsqz7    1/1     Running   0          28m
root@node-master:~/deployment# kubectl delete pod my-server-uat-deployement-6bd65dfd9c-cdkfl
pod "my-server-uat-deployement-6bd65dfd9c-cdkfl" deleted
root@node-master:~/deployment# kubectl  get pods 
NAME                                          READY   STATUS    RESTARTS   AGE
mc1                                           2/2     Running   0          4h52m
my-server-dev                                 1/1     Running   0          78m
my-server-prod                                1/1     Running   0          78m
my-server-prod-deployement-779fb6bfdb-k7h2l   1/1     Running   0          38m
my-server-prod-deployement-779fb6bfdb-mq9t7   1/1     Running   0          38m
my-server-prod-deployement-779fb6bfdb-q9f42   1/1     Running   0          38m
my-server-uat                                 1/1     Running   0          78m
my-server-uat-deployement-6bd65dfd9c-ks82b    1/1     Running   0          9s
my-server-uat-deployement-6bd65dfd9c-kvkdn    1/1     Running   0          28m
my-server-uat-deployement-6bd65dfd9c-lsqz7    1/1     Running   0          28m
```

explain ..... 

>> **Note**: **Note**: You should not manage ReplicaSets owned by a Deployment. All the use cases should be covered by manipulating the Deployment object. Consider opening an issue in the main Kubernetes repository if your use case is not covered below.


#### Replication Controller

The Replication Controller is the original form of replication in Kubernetes.  It’s being replaced by Replica Sets, but it’s still in wide use, so it’s worth understanding what it is and how it works.

A Replication Controller is a structure that enables you to easily create multiple pods, then make sure that that number of pods always exists. If a pod does crash, the Replication Controller replaces it.

Replication Controllers also provide other benefits, such as the ability to scale the number of pods, and to update or delete multiple pods with a single command.


an example of ...

``` yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: my-server-replicacontroller
spec:
  replicas: 2
  selector:
    app: my-server-controller
  template:
    metadata:
      labels:
        app: my-server-controller
    spec:
      containers:
      - name: my-server-controller
        image: nginx:1.15.4-alpine
        ports:
        -  containerPort: 80

```

``` bash 
# kubectl  get replicationcontroller
No resources found.
root@node-master:~/deployment# kubectl create -f  repli-controller.yaml
replicationcontroller/my-server-replicacontroller created
root@node-master:~/deployment# kubectl  get replicationcontroller
NAME                          DESIRED   CURRENT   READY   AGE
my-server-replicacontroller   2         2         2       5s
```
it will create 2 pods 
``` bash 
# kubectl  get pods
NAME                                          READY   STATUS    RESTARTS   AGE
...
my-server-replicacontroller-22q46             1/1     Running   0          85s
my-server-replicacontroller-j8jrk             1/1     Running   0          85s
...
```
....


##### Replica Sets

Replica Sets are a sort of hybrid, in that they are in some ways more powerful than Replication Controllers, and in others they are less powerful.

Replica Sets are declared in essentially the same way as Replication Controllers, except that they have more options for the selector.  For example, we could create a Replica Set like this:


 You can find more info about the controller [here](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)





##### Scaling up or down: Manually changing the number of replicas

One common task is to scale up a Deployment in response to additional load. Kubernetes has autoscaling, but we’ll talk about that in another article.  For now, let’s look at how to do this task manually.


> The most straightforward way is to simply use the scale command:

``` bash 
# kubectl  get deployments 
NAME                         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
my-server-prod-deployement   3         3         3            3           43m
my-server-uat-deployement    3         3         3            3           53m
root@node-master:~/deployment# kubectl  scale --replicas=5 deployment/my-server-uat-deployement
deployment.extensions/my-server-uat-deployement scaled
root@node-master:~/deployment# kubectl  get deployments 
NAME                         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
my-server-prod-deployement   3         3         3            3           44m
my-server-uat-deployement    5         5         5            5           54m
# kubectl  get pods | grep my-server-uat-deployement
my-server-uat-deployement-6bd65dfd9c-ks82b    1/1     Running   0          7m32s
my-server-uat-deployement-6bd65dfd9c-kvkdn    1/1     Running   0          35m
my-server-uat-deployement-6bd65dfd9c-lsqz7    1/1     Running   0          35m
my-server-uat-deployement-6bd65dfd9c-n8qgp    1/1     Running   0          110s
my-server-uat-deployement-6bd65dfd9c-trbsp    1/1     Running   0          33s

```
As you can see, we changed the number of replicas from 3 to 5

Go further by using the official doc [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)