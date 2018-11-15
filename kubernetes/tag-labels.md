### Organizing pods with labels


###### Specifying labels when creating a pod
we will create two pods, and each one with a specific label

nginx-label-dev.yaml
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-server-dev
  labels:
    app: my-server-dev
spec:
  containers:
  - image: nginx:1.15.4-alpine
    name: my-server-dev
    ports:
    - containerPort: 80

```
nginx-label-uat.yaml
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-server-uat
  labels:
    app: my-server-dev
spec:
  containers:
  - image: nginx:1.15.4-alpine
    name: my-server-uat
    ports:
    - containerPort: 80
```
nginx-label-prod.yaml
``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-server-prod
  labels:
    app: my-server-prod
spec:
  containers:
  - image: nginx:1.15.4-alpine
    name: my-server-prod
    ports:
    - containerPort: 80
```

seeing our pods 
``` bash 
# kubectl  get pods
NAME             READY   STATUS    RESTARTS   AGE
mc1              2/2     Running   0          3h27m
my-server-dev    1/1     Running   0          5s
my-server-prod   1/1     Running   0          15s
my-server-uat    1/1     Running   0          9s
```

###### Listing pods using a label selector
``` bash
# kubectl  get pods -l app=my-server-dev
NAME            READY   STATUS    RESTARTS   AGE
my-server-dev   1/1     Running   0          68s
my-server-uat   1/1     Running   0          73s
```
Please note the pods my-server-dev and my-server-uat have the same label

``` bash 
# kubectl  describe pods -l app=my-server-dev
Name:               my-server-dev
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-2/10.132.0.3
Start Time:         Tue, 06 Nov 2018 19:25:04 +0000
Labels:             app=my-server-dev
Annotations:        <none>
Status:             Running
IP:                 10.34.0.1
Containers:
  my-server-dev:
    Container ID:   docker://b4862da6b578e662000e2c0f711fa660cbda345f0f61fa7de55ac39ba2c0fc20
    Image:          nginx:1.15.4-alpine
    Image ID:       docker-pullable://nginx@sha256:fd0361ff0882d63eec241705ba169d83c042bf27f8b568aedd131c2ab97246f0
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 06 Nov 2018 19:25:04 +0000
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
  Normal  Scheduled  2m15s  default-scheduler  Successfully assigned default/my-server-dev to node-2
  Normal  Pulled     2m15s  kubelet, node-2    Container image "nginx:1.15.4-alpine" already present on machine
  Normal  Created    2m15s  kubelet, node-2    Created container
  Normal  Started    2m15s  kubelet, node-2    Started container


Name:               my-server-uat
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-1/10.132.0.2
Start Time:         Tue, 06 Nov 2018 19:24:59 +0000
Labels:             app=my-server-dev
Annotations:        <none>
Status:             Running
IP:                 10.40.0.3
Containers:
  my-server-uat:
    Container ID:   docker://747455c6cc5bc74a12d1b4206731fb701e0d7d5046ecd925381881d8c2092631
    Image:          nginx:1.15.4-alpine
    Image ID:       docker-pullable://nginx@sha256:fd0361ff0882d63eec241705ba169d83c042bf27f8b568aedd131c2ab97246f0
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 06 Nov 2018 19:25:00 +0000
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
  Normal  Scheduled  2m20s  default-scheduler  Successfully assigned default/my-server-uat to node-1
  Normal  Pulled     2m19s  kubelet, node-1    Container image "nginx:1.15.4-alpine" already present on machine
  Normal  Created    2m19s  kubelet, node-1    Created container
  Normal  Started    2m19s  kubelet, node-1    Started container
```



###### Update pod ' my-server-uat' with the label 'unhealthy' and the value 'true'.
``` bash 
# kubectl label pods my-server-uat unhealthy=true
pod/my-server-uat labeled
root@node-master:~/labels# kubectl describe pod my-server-uat
Name:               my-server-uat
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node-1/10.132.0.2
Start Time:         Tue, 06 Nov 2018 19:24:59 +0000
Labels:             app=my-server-dev
                    unhealthy=true
Annotations:        <none>
Status:             Running
IP:                 10.40.0.3
Containers:
  my-server-uat:
    Container ID:   docker://747455c6cc5bc74a12d1b4206731fb701e0d7d5046ecd925381881d8c2092631
    Image:          nginx:1.15.4-alpine
    Image ID:       docker-pullable://nginx@sha256:fd0361ff0882d63eec241705ba169d83c042bf27f8b568aedd131c2ab97246f0
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 06 Nov 2018 19:25:00 +0000
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  8m5s  default-scheduler  Successfully assigned default/my-server-uat to node-1
  Normal  Pulled     8m4s  kubelet, node-1    Container image "nginx:1.15.4-alpine" already present on machine
  Normal  Created    8m4s  kubelet, node-1    Created container
  Normal  Started    8m4s  kubelet, node-1    Started container
```

so you can the label that we craeted to filter
``` bash
# kubectl describe pods -l unhealthy=true
....
#kubectl get pods -l unhealthy=true
NAME            READY   STATUS    RESTARTS   AGE
my-server-uat   1/1     Running   0          10m
```
after you fix the issue of the pod you decide to make it healthy again, so you need to modify its label.

###### Modifying labels of existing pods
```bash 
# kubectl label pods my-server-uat unhealthy=false --overwrite
pod/my-server-uat labeled
root@node-master:~/labels# kubectl get  pods -l unhealthy=true
No resources found.
root@node-master:~/labels# kubectl get  pods -l unhealthy=false
NAME            READY   STATUS    RESTARTS   AGE
my-server-uat   1/1     Running   0          12m
```
>>``--overwrite`` flag :
the existed labels can be overwritten, otherwise attempting to overwrite a label will result in an error.

More Info about the label 
``` bash
kubectl label --help
```



