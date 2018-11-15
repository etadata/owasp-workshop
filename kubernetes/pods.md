### Pod Definition

A pod (as in a pod of whales or pea pod) is a group of one or more containers (such as Docker containers), with shared storage/network, 
and a specification for how to run the containers. A pod’s contents are always co-located and co-scheduled, and run in a shared context. A pod models an application-specific “logical host” - it contains one or more application containers which are relatively tightly coupled — in a pre-container world, being executed on the same physical or virtual machine would mean being executed on the same logical host.


####  Create and Deploy Pod Definitions


there are 2 kind of pods : 

    -  multiple pod 
    -  signle pod 


##### Single Container Pod using the command line

They can be simply created with the kubctl run command, where you have a defined image on the Docker registry which we will pull while creating a pod.

lets create a single pod from the command line and test our image(webserver)

``` bash 
# kubectl  run my-shell --rm -it --image abdelhalim/apache2:webserver bash 
kubectl run --generator=deployment/apps.v1beta1 is DEPRECATED and will be removed in a future version. Use kubectl create instead.
If you don't see a command prompt, try pressing enter.
root@my-shell-79d55fccc6-r9wls:/# 
root@my-shell-79d55fccc6-r9wls:/#
root@my-shell-79d55fccc6-r9wls:/# /etc/init.d/apache2 start 
 * Starting Apache httpd web server apache2                                                                                                                                                                        AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.40.0.2. Set the 'ServerName' directive globally to suppress this message
 * 
root@my-shell-79d55fccc6-r9wls:/# curl http://localhost
Helo Owasp Lab
```
The ``--rm`` switch tells kubectl to delete the deployment and the pod once the command is run, while ``-ti`` asks it to attach a tty to the container, and make it connect to the stdin of the container process. 

The ``--image`` argument specifies a lightweight alpine-based image with some debugging utilities, and the last argument is the command to use instead of the entry point of the container
let's

>> the command ``kubernetes run`` create a Deployment. This can be seen by listing the deployments:

Create a pod from CLI :

``` bash 
# kubectl run static-web      --image nginx   --image-pull-policy=IfNotPresent      --port=80
```
get the pods 

```bash
# kubectl get pods 
NAME                                 READY   STATUS             RESTARTS   AGE
static-web-74564475d9-9vltv          1/1     Running            0          3m1s
```

get more information about our pod by using the command line describe

``` bash
# kubectl  describe pod static-web-74564475d9-9vltv
Name:               static-web-74564475d9-9vltv
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-1/10.132.0.2
Start Time:         Tue, 06 Nov 2018 14:51:00 +0000
Labels:             pod-template-hash=74564475d9
                    run=static-web
Annotations:        <none>
Status:             Running
IP:                 10.40.0.3
Controlled By:      ReplicaSet/static-web-74564475d9
Containers:
  static-web:
    Container ID:   docker://12ca382d097151159f4a25c2e04af757b0ae56497698650d5d86e70256059c2f
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:b73f527d86e3461fd652f62cf47e7b375196063bbbd503e853af5be16597cb2e
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 06 Nov 2018 14:51:01 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-gfpbt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-gfpbt:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-gfpbt
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  5m34s  default-scheduler  Successfully assigned default/static-web-74564475d9-9vltv to node-1
  Normal  Pulled     5m33s  kubelet, node-1    Container image "nginx" already present on machine
  Normal  Created    5m33s  kubelet, node-1    Created container
  Normal  Started    5m33s  kubelet, node-1    Started container
```

we see that our pod has been craeted inside the node-1
```bash
root@node-1:~# docker ps -l | grep nginx
12ca382d0971        dbfc48660aeb        "nginx -g 'daemon ..."   6 minutes ago       Up 6 minutes                            k8s_static-web_static-web-74564475d9-9vltv_default_605ed3aa-e1d3-11e8-9e2a-42010a840004_0
```
if you like to go isnide the container or execute a specific command

``` bash 
# docker ps -l
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
12ca382d0971        dbfc48660aeb        "nginx -g 'daemon ..."   9 minutes ago       Up 9 minutes                            k8s_static-web_static-web-74564475d9-9vltv_default_605ed3aa-e1d3-11e8-9e2a-42010a840004_0
root@node-1:~# docker exec -it k8s_static-web_static-web-74564475d9-9vltv_default_605ed3aa-e1d3-11e8-9e2a-42010a840004_0 /bin/bash
root@static-web-74564475d9-9vltv:/#      

```

More Info about the pod 

```bash 
# kubectl proxy &
# curl http://localhost:8001/api/v1/namespaces/default/pods/static-web-74564475d9-9vltv
{
  "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    "name": "static-web-74564475d9-9vltv",
    "generateName": "static-web-74564475d9-",
    "namespace": "default",
    "selfLink": "/api/v1/namespaces/default/pods/static-web-74564475d9-9vltv",
    "uid": "605ed3aa-e1d3-11e8-9e2a-42010a840004",
    "resourceVersion": "28917",
    "creationTimestamp": "2018-11-06T14:51:00Z",
    "labels": {
      "pod-template-hash": "74564475d9",
      "run": "static-web"
    },
    "ownerReferences": [
      {
        "apiVersion": "apps/v1",
        "kind": "ReplicaSet",
        "name": "static-web-74564475d9",
        "uid": "605afd3d-e1d3-11e8-9e2a-42010a840004",
        "controller": true,
        "blockOwnerDeletion": true
      }
    ]
  },
  "spec": {
    "volumes": [
      {
        "name": "default-token-gfpbt",
        "secret": {
          "secretName": "default-token-gfpbt",
          "defaultMode": 420
        }
      }
    ],
    "containers": [
      {
        "name": "static-web",
        "image": "nginx",
        "ports": [
          {
            "containerPort": 80,
            "protocol": "TCP"
          }
        ],
        "resources": {
          
        },
        "volumeMounts": [
          {
            "name": "default-token-gfpbt",
            "readOnly": true,
            "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount"
          }
        ],
        "terminationMessagePath": "/dev/termination-log",
        "terminationMessagePolicy": "File",
        "imagePullPolicy": "IfNotPresent"
      }
    ],
    "restartPolicy": "Always",
    "terminationGracePeriodSeconds": 30,
    "dnsPolicy": "ClusterFirst",
    "serviceAccountName": "default",
    "serviceAccount": "default",
    "nodeName": "node-1",
    "securityContext": {
      
    },
    "schedulerName": "default-scheduler",
    "tolerations": [
      {
        "key": "node.kubernetes.io/not-ready",
        "operator": "Exists",
        "effect": "NoExecute",
        "tolerationSeconds": 300
      },
      {
        "key": "node.kubernetes.io/unreachable",
        "operator": "Exists",
        "effect": "NoExecute",
        "tolerationSeconds": 300
      }
    ],
    "priority": 0
  },
  "status": {
    "phase": "Running",
    "conditions": [
      {
        "type": "Initialized",
        "status": "True",
        "lastProbeTime": null,
        "lastTransitionTime": "2018-11-06T14:51:00Z"
      },
      {
        "type": "Ready",
        "status": "True",
        "lastProbeTime": null,
        "lastTransitionTime": "2018-11-06T14:51:02Z"
      },
      {
        "type": "ContainersReady",
        "status": "True",
        "lastProbeTime": null,
        "lastTransitionTime": "2018-11-06T14:51:02Z"
      },
      {
        "type": "PodScheduled",
        "status": "True",
        "lastProbeTime": null,
        "lastTransitionTime": "2018-11-06T14:51:00Z"
      }
    ],
    "hostIP": "10.132.0.2",
    "podIP": "10.40.0.3",
    "startTime": "2018-11-06T14:51:00Z",
    "containerStatuses": [
      {
        "name": "static-web",
        "state": {
          "running": {
            "startedAt": "2018-11-06T14:51:01Z"
          }
        },
        "lastState": {
          
        },
        "ready": true,
        "restartCount": 0,
        "image": "nginx:latest",
        "imageID": "docker-pullable://nginx@sha256:b73f527d86e3461fd652f62cf47e7b375196063bbbd503e853af5be16597cb2e",
        "containerID": "docker://12ca382d097151159f4a25c2e04af757b0ae56497698650d5d86e70256059c2f"
      }
    ],
    "qosClass": "BestEffort"
  }
} # 

```


##### Creating pods from YAML  descriptor

edit the file web-server.yaml
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: webserver
spec:
  containers:
  - image: abdelhalim/static_web:version_web
    name: webserver
    ports:
    - containerPort: 80
      name: web
```

then execute the command 
```bash
# kubectl create -f web-server.yaml
```



###### Viewing application logs
get the logs of a secific pod
``` bash 
# kubectl logs static-web-74564475d9-9vltv
127.0.0.1 - - [06/Nov/2018:15:02:48 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.52.1" "-"
```





``` bash 
# kubectl  get deployments
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
static-web   1         1         1            1           15m
```
we will see what more info about the deployment later in this workshop 


##### Multi Container Pod

edit multi-container-pod.yaml  file 
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: mc1
spec:
  volumes:
  - name: html
    emptyDir: {}
  containers:
  - name: 1st
    image: nginx
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
  - name: 2nd
    image: debian
    volumeMounts:
    - name: html
      mountPath: /html
    command: ["/bin/sh", "-c"]
    args:
      - while true; do
          echo "Hello Owasp 2018    `date`" > /html/index.html;
          sleep 1;
        done

```
In this example, we define a volume named html. Its type is emptyDir, which means that the volume is first created when a Pod is assigned to a node, and exists as long as that Pod is running on that node. As the name says, it is initially empty. The 1st container runs nginx server and has the shared volume mounted to the directory /usr/share/nginx/html. The 2nd container uses the Debian image and has the shared volume mounted to the directory /html. Every second, the 2nd container adds the current date and time into the index.html file, which is located in the shared volume. When the user makes an HTTP request to the Pod, the Nginx server reads this file and transfers it back to the user in response to the request


image : here




``` bash
# kubectl create -f  multi-container-pod.yaml 
pod/mc1 created
 # kubectl describe pod mc1
Name:               mc1
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-2/10.132.0.3
Start Time:         Tue, 06 Nov 2018 15:41:21 +0000
Labels:             <none>
Annotations:        <none>
Status:             Running
IP:                 10.34.0.0
Containers:
  1st:
    Container ID:   docker://87b84760c4b4877fe17547b0928817133ce0803f4fad8256ad8185ce483cce40
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:b73f527d86e3461fd652f62cf47e7b375196063bbbd503e853af5be16597cb2e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 06 Nov 2018 15:41:24 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /usr/share/nginx/html from html (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-gfpbt (ro)
  2nd:
    Container ID:  docker://57f47dc7cda05b15bcf7ace909a70748666cd02cb1347905da0ab319fb166e59
    Image:         debian
    Image ID:      docker-pullable://debian@sha256:802706fa62e75c96fff96ada0e8ca11f570895ae2e9ba4a9d409981750ca544c
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
    Args:
      while true; do echo "Hello Owasp 2018" &&  date > /html/index.html; sleep 1; done
    State:          Running
      Started:      Tue, 06 Nov 2018 15:41:25 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /html from html (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-gfpbt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  html:
    Type:    EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:  
  default-token-gfpbt:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-gfpbt
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  17s   default-scheduler  Successfully assigned default/mc1 to node-2
  Normal  Pulling    16s   kubelet, node-2    pulling image "nginx"
  Normal  Pulled     15s   kubelet, node-2    Successfully pulled image "nginx"
  Normal  Created    15s   kubelet, node-2    Created container
  Normal  Started    14s   kubelet, node-2    Started container
  Normal  Pulling    14s   kubelet, node-2    pulling image "debian"
  Normal  Pulled     13s   kubelet, node-2    Successfully pulled image "debian"
  Normal  Created    13s   kubelet, node-2    Created container
  Normal  Started    13s   kubelet, node-2    Started container
```

``` bash 
l# curl http://10.34.0.0
Hello Owasp 2018    Tue Nov  6 15:52:46 UTC 2018 
 # 

```

You can check that the pod is working either by exposing the nginx port and accessing it using your browser, or by checking the shared directory directly in the containers:

``` bash 
# kubectl exec mc1 -c 1st -- /bin/cat /usr/share/nginx/html/index.html
Hello Owasp 2018    Tue Nov  6 15:53:43 UTC 2018 
```

see the logs of the 1st container of the pod mc1 
``` bash 
# kubectl  logs mc1 1st
10.38.0.0 - - [06/Nov/2018:15:52:46 +0000] "GET / HTTP/1.1" 200 50 "-" "curl/7.47.0" "-"
```

##### Interacting with the pod
``` bash 
# kubectl exec mc1 -c 1st date 
Tue Nov  6 22:06:15 UTC 2018
```

```bash
Interacting with running Pods

kubectl logs my-pod                                 # dump pod logs (stdout)
kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
kubectl logs -f my-pod                              # stream pod logs (stdout)
kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
kubectl attach my-pod -i                            # Attach to Running Container
kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers
```

Expose the pod service 

``` bash 
# kubectl  port-forward mc1 9955:80 &
[2] 6973
 # Forwarding from 127.0.0.1:9955 -> 80
Forwarding from [::1]:9955 -> 80

 # netstat  -antpl | grep 9955
tcp        0      0 127.0.0.1:9955          0.0.0.0:*               LISTEN      6973/kubectl    
tcp6       0      0 ::1:9955                :::*                    LISTEN      6973/kubectl    
 # curl http://localhost:9955
Handling connection for 9955
Hello Owasp 2018    Tue Nov  6 16:00:45 UTC 2018 
# # OR
## wget -qO- http://localhost:9955
Handling connection for 9955
Hello Owasp 2018    Tue Nov  6 16:02:07 UTC 2018 
 # 
```

#### Deleting a pod by name
``` bash 
kubectl delete pod mc1
```
#### Delete multiple pods 
``` bash 
#kubectl delete pods <pod1> [pod1] ...
```
#### Deleting pods using label selectors
```bash
#kubectl delete pods -l name=myLabel
```
#### Delete all pods
  kubectl delete pods --all



More infor : use the command ``--help``
```bash
# kubectl  delete --help
```
### the deployment 
when you craete the pod from the command line. kubernetes will create a deployment for you.

**``Deployments``** are one of the special kinds of resources in the Kubernetes world, in that they are responsible for managing the lifetime of application containers. These kinds of resources are called controllers, and they are central to the Kubernetes puzzle. You can get more detailed info about the new deployment with kubectl describe deployments simple-python-app



the deployments :
```bash
root@node-master:~# kubectl  get deployments
NAME                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
my-shell            1         1         1            1           6m55s
simple-static-web   1         1         1            0           17m
root@node-master:~# 
```

create pod from yaml file
``` bash
# cat web-server.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: web-server
spec:
  containers:
  - image: abdelhalim/static_web:version_web
    name: web-server
    ports:
    - containerPort: 80
      name: web
```
``` bash 
# kubectl  create -f web-server.yaml 
pod/web-server created
root@node-master:~/pod# 
root@node-master:~/pod# 
root@node-master:~/pod# kubectl  get pods
NAME         READY   STATUS      RESTARTS   AGE
web-server   0/1     Completed   2          26s
root@node-master:~/pod# 
 ```

``` bash
kubectl describe pod <nginx>
```

``` bash 
# kubectl  describe pod webserver
Name:               webserver
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-2/10.132.0.3
Start Time:         Tue, 06 Nov 2018 14:23:11 +0000
Labels:             <none>
Annotations:        <none>
Status:             Running
IP:                 10.34.0.0
Containers:
  webserver:
    Container ID:   docker://d2f4b12c743ea21e998dc96067470d6beb7974d2fff66108da2d71a717508d35
    Image:          abdelhalim/static_web:version_web
    Image ID:       docker-pullable://abdelhalim/static_web@sha256:fa70e31629c7c563fcad3246405f157d8af8ef5e7a6fc91ca49f482fd636757d
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 06 Nov 2018 14:23:32 +0000
      Finished:     Tue, 06 Nov 2018 14:23:32 +0000
    Ready:          False
    Restart Count:  2
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-gfpbt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  default-token-gfpbt:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-gfpbt
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  46s                default-scheduler  Successfully assigned default/webserver to node-2
  Normal   Pulling    45s                kubelet, node-2    pulling image "abdelhalim/static_web:version_web"
  Normal   Pulled     43s                kubelet, node-2    Successfully pulled image "abdelhalim/static_web:version_web"
  Normal   Created    25s (x3 over 43s)  kubelet, node-2    Created container
  Normal   Started    25s (x3 over 42s)  kubelet, node-2    Started container
  Normal   Pulled     25s (x2 over 42s)  kubelet, node-2    Container image "abdelhalim/static_web:version_web" already present on machine
  Warning  BackOff    12s (x4 over 41s)  kubelet, node-2    Back-off restarting failed container
root@node-master:~/pod# kubectl  get pods 
NAME        READY   STATUS      RESTARTS   AGE
webserver   0/1     Completed   3          51s
```



Create a pod from a cmmand line 

```bash
kubectl run "type here the complete command" 
```

access to pod service internally for expmle nginx or apache 
``` bash
wget -q0- http://172.20.20.1
```


 #### get the documentation for pod and svc manifests
``` bash
kubectl explain pods,svc                      
```