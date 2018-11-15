
#### Create and Deploy Service Definitions

Pods aren't meant to be persistent. They can be stopped or started for many reasons -- like failed liveness or readiness checks -- and this leads to a problem:

What happens if we want to communicate with a set of Pods? When they get restarted they might have a different IP address.

That's where ``Services``(lien) come in.

A Kubernetes Service is an abstraction which defines a logical set of Pods and a policy by which to access them - sometimes called a micro-service. The set of Pods targeted by a Service is (usually) determined by a [``Label Selector`` ](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors).

If Pods have the correct labels, they are automatically picked up ap and exposed by our services.

The level of access a service provides to a set of pods depends on the Service's type. Currently there are three types:

1. ClusterIP (internal) -- the default type means that this Service is only visible inside of the cluster,

2. NodePort gives each node in the cluster an externally accessible IP and

3. LoadBalancer adds a load balancer from the cloud provider which forwards traffic from the service to Nodes within it.


Services provide stable endpoints for Pods


create a service yaml file  by editing the file  ``my-service-prod.yaml``
```yaml 
apiVersion: v1
kind: Service
metadata:
  name: my-service-prod
  labels:
    app: my-service-prod
spec:
  ports:
    - port: 8088
      targetPort: 80
      protocol: TCP
  selector:
    app: my-server-prod
```

 execute 

```bash
 # kubectl get pods -l app=my-server-prod
NAME             READY   STATUS    RESTARTS   AGE
my-server-prod   1/1     Running   0          131m
# kubectl get services
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   12h
root@node-master:~/services# kubectl  create -f my-service-prod.yaml 
service/my-service-prod created
root@node-master:~/services# kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP    12h
my-service-prod     ClusterIP   10.102.110.132   <none>        8088/TCP   12s
```

 get the services 

```bash
kubectl get services
```


get the description of a service 
```bash
# kubectl  describe service my-service-prod
Name:              my-service-prod
Namespace:         default
Labels:            app=my-service-prod
Annotations:       <none>
Selector:          app=my-server-prod
Type:              ClusterIP
IP:                10.102.110.132
Port:              <unset>  8088/TCP
TargetPort:        web/TCP
Endpoints:         <none>
Session Affinity:  None
Events:            <none>
```

Now we can access to the prod server via the ip 10.102.110.132  port 8088

``` bash 
s# curl http://10.102.110.132:8088
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


Create a Service object that exposes the deployment:
``` bash
# kubectl  get deployments 
NAME                         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
my-server-prod-deployement   3         3         3            3           135m
my-server-uat-deployement    2         2         2            2           145m

#kubectl  expose deployment my-server-prod-deployement --type=LoadBalancer --name=server-prod
```




#### Publish your service


my-public-server.yaml

``` yaml
kind: Service
apiVersion: v1
metadata:
  name: "public-server"
spec:
  selector:
    app: "my-server-prod-deployement"
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 80
      nodePort: 32003
  type: NodePort
```


then 
``` bash
# kubectl  create -f my-public-server.yaml 
service/public-server created
root@node-master:~/services# kubectl  describe service public-server
Name:                     public-server
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=my-server-prod-deployement
Type:                     NodePort
IP:                       10.99.97.15
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  32003/TCP
Endpoints:                10.34.0.4:80,10.40.0.8:80,10.40.0.9:80
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
```

if you are using the  google cloud
use the following command to allow the traffic

``` bash
gcloud compute firewall-rules create allow-my-server-nodeport --allow=tcp:32003
```

then go to your browser and navigate http://<external-ip>:32003


delete a service 

```bash
kubectl delete service <service-name>
```

delete multiple services

``` bash
kubectl delete services <service-name-1> [<service-name-2>] ...
```
