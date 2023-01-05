# Домашнее задание к занятию "13.3 работа с kubectl"
## Задание 1: проверить работоспособность каждого компонента
Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:
* сделайте запросы к бекенду;
* сделайте запросы к фронту;
* подключитесь к базе данных.

## Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

# Ответ:

## Задание 1.

### Stage

### Запрос к фронтенду:


<details>
<summary>kubectl exec front-back-7fc6fd4975-sxk98 -c front --namespace=stage -- curl http://localhost:80</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec front-back-7fc6fd4975-sxk98 -c front --namespace=stage -- curl http://localhost:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   437k      0 --:--:-- --:--:-- --:--:--  437k
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec front-back-7fc6fd4975-sxk98 -c back --namespace=stage -- curl http://localhost:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   <!DOCTYPE html>--:-- --:--:-- --:--:--     0
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>218k      0 --:--:-- --:--:-- --:--:--  218k
```

</details>


![img_40.png](img_40.png)

![img_41.png](img_41.png)

### Запрос к бекенду:

<details>
<summary>kubectl exec front-back-7fc6fd4975-sxk98 -c front --namespace=stage -- curl http://localhost:9000/api/news/</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec front-back-7fc6fd4975-sxk98 -c front --namespace=stage -- curl http://localhost:9000/api/news/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
1[{"id":1,"title":"title 0","short_description":"small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0","preview":"/static/image.png"},{"id":2,"title":"title 1","short_description":"small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1","preview":"/static/image.png"},{"id":3,"title":"title 2","short_description":"small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2","preview":"/static/image.png"},{"id":4,"title":"title 3","short_description":"small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3","preview":"/static/image.png"},{"id":5,"title":"title 4","short_description":"small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4","preview":"/static/image.png"},{"id":6,"title":"title 5","short_description":"small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5","preview":"/static/image.png"},{"id":7,"title":"title 6","short_description":"small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6","preview":"/static/image.png"},{"id":8,"title":"title 7","short_description":"small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7","preview":"/static/image.png"},{"id":9,"title":"title 8","short_description":"small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8","preview":"/static/image.png"},{"id":10,"title":"title 9","short_description":"small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9","preview":"/static/image.png"},{"id":11,"title":"title 10","short_description":"small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10","preview":"/static/image.png"},{"id":12,"title":"title 11","short_description":"small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11","preview":"/static/image.png"},{"id":13,"title":"title 12","short_description":"small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12","preview":"/static/image.png"},{"id":14,"title":"title 13","short_description":"small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13","preview":"/static/image.png"},{"id":15,"title":"title 14","short_description":"small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14","preview":"/static/image.png"},{"id":16,"title":"title 15","short_description":"small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15","preview":"/static/image.png"},{"id":17,"title":"title 16","short_description":"small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16","preview":"/static/image.png"},{"id":18,"title":"title 17","short_description":"small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17","preview":"/static/image.png"},{"id":19,"title":"title 18","short_description":"small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18","preview":"/static/image.png"},{"id":20,"title":"title 19","short_description":"small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19","prev00  5182  100  5182    0     0  79723      0 --:--:-- --:--:-- --:--:-- 79723
iew":"/static/image.png"},{"id":21,"title":"title 20","short_description":"small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20","preview":"/static/image.png"},{"id":22,"title":"title 21","short_description":"small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21","preview":"/static/image.png"},{"id":23,"title":"title 22","short_description":"small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22","preview":"/static/image.png"},{"id":24,"title":"title 23","short_description":"small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23","preview":"/static/image.png"},{"id":25,"title":"title 24","short_description":"small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24","preview":"/static/image.png"}]dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec front-back-7fc6fd4975-sxk98 -c back --namespace=stage -- curl http://localhost:9000/api/news/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5182  100  5182    0     0   843k      0 --:--:-- --:--:-- --:--:--  843k
[{"id":1,"title":"title 0","short_description":"small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0","preview":"/static/image.png"},{"id":2,"title":"title 1","short_description":"small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1small text 1","preview":"/static/image.png"},{"id":3,"title":"title 2","short_description":"small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2small text 2","preview":"/static/image.png"},{"id":4,"title":"title 3","short_description":"small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3small text 3","preview":"/static/image.png"},{"id":5,"title":"title 4","short_description":"small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4small text 4","preview":"/static/image.png"},{"id":6,"title":"title 5","short_description":"small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5small text 5","preview":"/static/image.png"},{"id":7,"title":"title 6","short_description":"small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6small text 6","preview":"/static/image.png"},{"id":8,"title":"title 7","short_description":"small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7small text 7","preview":"/static/image.png"},{"id":9,"title":"title 8","short_description":"small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8small text 8","preview":"/static/image.png"},{"id":10,"title":"title 9","short_description":"small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9small text 9","preview":"/static/image.png"},{"id":11,"title":"title 10","short_description":"small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10small text 10","preview":"/static/image.png"},{"id":12,"title":"title 11","short_description":"small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11small text 11","preview":"/static/image.png"},{"id":13,"title":"title 12","short_description":"small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12small text 12","preview":"/static/image.png"},{"id":14,"title":"title 13","short_description":"small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13small text 13","preview":"/static/image.png"},{"id":15,"title":"title 14","short_description":"small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14small text 14","preview":"/static/image.png"},{"id":16,"title":"title 15","short_description":"small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15small text 15","preview":"/static/image.png"},{"id":17,"title":"title 16","short_description":"small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16small text 16","preview":"/static/image.png"},{"id":18,"title":"title 17","short_description":"small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17small text 17","preview":"/static/image.png"},{"id":19,"title":"title 18","short_description":"small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18small text 18","preview":"/static/image.png"},{"id":20,"title":"title 19","short_description":"small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19small text 19","preview":"/static/image.png"},{"id":21,"title":"title 20","short_description":"small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20small text 20","preview":"/static/image.png"},{"id":22,"title":"title 21","short_description":"small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21small text 21","preview":"/static/image.png"},{"id":23,"title":"title 22","short_description":"small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22small text 22","preview":"/static/image.png"},{"id":24,"title":"title 23","short_description":"small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23small text 23","preview":"/static/image.png"},{"id":25,"title":"title 24","short_description":"small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24small text 24","preview":"/static/image.png"}]dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ 
```
</details>

![img_42.png](img_42.png)
![img_43.png](img_43.png)

### Запрос к БД:

```shell
kubectl exec db-0 -- psql -U postgres -d news -c \\dt
```

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec db-0 --namespace=stage  -- psql -U postgres -d news -c \\l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl exec db-0 --namespace=stage  -- psql -U postgres -d news -c \\dt
        List of relations
 Schema | Name | Type  |  Owner   
--------+------+-------+----------
 public | news | table | postgres
(1 row)
```
![img_44.png](img_44.png)

### port-forward

### Фронтенд:

```shell
kubectl port-forward service/front-back-svc --namespace=stage 8080:8000
```
![img_46.png](img_46.png)

### Бекенд:

```shell
kubectl port-forward service/front-back-svc --namespace=stage 9080:9000
```
![img_45.png](img_45.png)

### Запросы к БД:

```shell
psql -Upostgres -h localhost -p 9432
````

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ psql -Upostgres -h localhost -p 9432
psql (14.5 (Ubuntu 14.5-0ubuntu0.22.04.1), server 13.9)
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

postgres=# \c news
psql (14.5 (Ubuntu 14.5-0ubuntu0.22.04.1), server 13.9)
You are now connected to database "news" as user "postgres".
news=# \dt
        List of relations
 Schema | Name | Type  |  Owner   
--------+------+-------+----------
 public | news | table | postgres
(1 row)
news=# \d+ news
                                                           Table "public.news"
      Column       |       Type        | Collation | Nullable |             Default              | Storage  | Stats target | Description 
-------------------+-------------------+-----------+----------+----------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('news_id_seq'::regclass) | plain    |              | 
 title             | character varying |           |          |                                  | extended |              | 
 short_description | character varying |           |          |                                  | extended |              | 
 description       | character varying |           |          |                                  | extended |              | 
 preview           | character varying |           |          |                                  | extended |              | 
Indexes:
    "news_pkey" PRIMARY KEY, btree (id)
Access method: heap

news=# select title from news limit 10;
  title  
---------
 title 0
 title 1
 title 2
 title 3
 title 4
 title 5
 title 6
 title 7
 title 8
 title 9
(10 rows)

```
![img_47.png](img_47.png)

## Задание 2.

### Исходное состояние подов:

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl get pods --namespace=prod -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
back-8485b7bfbd-l2pcj   1/1     Running   0          4h16m   10.233.102.135   node1   <none>           <none>
db-0                    1/1     Running   0          6h13m   10.233.102.133   node1   <none>           <none>
front-59589466b-wpdhb   1/1     Running   0          4h16m   10.233.75.7      node2   <none>           <none>
```

![img_48.png](img_48.png)

<details>
<summary>kubectl describe pods --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe pods --namespace=prod
Name:             back-8485b7bfbd-l2pcj
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 02:48:16 +0300
Labels:           app=back
                  pod-template-hash=8485b7bfbd
Annotations:      cni.projectcalico.org/containerID: a8e3aa39c2ee6fe84ef23a9f1560e2c72482e01e451913bf936ab9a2adbf3dce
                  cni.projectcalico.org/podIP: 10.233.102.135/32
                  cni.projectcalico.org/podIPs: 10.233.102.135/32
Status:           Running
IP:               10.233.102.135
IPs:
  IP:           10.233.102.135
Controlled By:  ReplicaSet/back-8485b7bfbd
Containers:
  back:
    Container ID:   containerd://13c2da2b4cf0c1ee36a07e60de409483e7a637679cdda19fe224e79fac8cfb4b
    Image:          dmi3x3/13-kubernetes-config_backend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_backend@sha256:bf7c946a16631879bd2a047791e11f658bf0ee63a916174c04ec7b79d6ea9337
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 02:48:18 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@postgres.prod.svc.cluster.local:5432/news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6d2rz (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-6d2rz:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>


Name:             db-0
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 00:51:19 +0300
Labels:           app=db
                  controller-revision-hash=db-dfc8cd59d
                  statefulset.kubernetes.io/pod-name=db-0
Annotations:      cni.projectcalico.org/containerID: 168ef050707dcff32345c6bbe11fb6f65693b86e873b18137fdb26d8ab0e0b74
                  cni.projectcalico.org/podIP: 10.233.102.133/32
                  cni.projectcalico.org/podIPs: 10.233.102.133/32
Status:           Running
IP:               10.233.102.133
IPs:
  IP:           10.233.102.133
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://9c1e9a43d2a10bf25007158079644b835b97f1ee5b792679c2e27eef831d8fd0
    Image:          postgres:13-alpine
    Image ID:       docker.io/library/postgres@sha256:93924d8dbf68fef91ed3252a956a0668a609fc8a6693c7e4a519b0cca71b9203
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 05 Jan 2023 00:51:20 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_DB:        news
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      PGDATA:             /data/pgdata
    Mounts:
      /data from pv-prod (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zzxrs (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  pv-prod:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pv-prod-db-0
    ReadOnly:   false
  kube-api-access-zzxrs:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>


Name:             front-59589466b-wpdhb
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node2/10.1.2.33
Start Time:       Thu, 05 Jan 2023 02:48:08 +0300
Labels:           app=front
                  pod-template-hash=59589466b
Annotations:      cni.projectcalico.org/containerID: 60f91d0d43b5125fa6f9cc6f3f7a087799312f80c9dff77d8df1947d20382ad3
                  cni.projectcalico.org/podIP: 10.233.75.7/32
                  cni.projectcalico.org/podIPs: 10.233.75.7/32
Status:           Running
IP:               10.233.75.7
IPs:
  IP:           10.233.75.7
Controlled By:  ReplicaSet/front-59589466b
Containers:
  front:
    Container ID:   containerd://6ffac39336556706f2e11cd7315101118d1fca8be7dde3b0eb106515a9922c45
    Image:          dmi3x3/13-kubernetes-config_frontend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_frontend@sha256:27355ae95dce068c7349fada1c49566b5ccdb89aa0618c4f3b95faf0fff133b1
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 02:48:09 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      BASE_URL:  http://back-svc.prod.svc.cluster.local:9000
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-h4cxx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-h4cxx:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```
</details>


<details>
<summary>kubectl describe svc --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe svc --namespace=prod
Name:              back-svc
Namespace:         prod
Labels:            app=back
Annotations:       <none>
Selector:          app=back
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.41.253
IPs:               10.233.41.253
Port:              9000  9000/TCP
TargetPort:        9000/TCP
Endpoints:         10.233.102.135:9000
Session Affinity:  None
Events:            <none>


Name:              front-svc
Namespace:         prod
Labels:            <none>
Annotations:       <none>
Selector:          app=front
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.55.66
IPs:               10.233.55.66
Port:              8000  8000/TCP
TargetPort:        80/TCP
Endpoints:         10.233.75.7:80
Session Affinity:  None
Events:            <none>


Name:              postgres
Namespace:         prod
Labels:            app=db
Annotations:       <none>
Selector:          app=db
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.21.78
IPs:               10.233.21.78
Port:              5432  5432/TCP
TargetPort:        5432/TCP
Endpoints:         10.233.102.133:5432
Session Affinity:  None
Events:            <none>
```
</details>


### Увеличил количество реплик front и back до трех:


```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl scale --replicas=3 deployment/back --namespace=prod
deployment.apps/back scaled
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl get pods --namespace=prod -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
back-8485b7bfbd-7w7rp   1/1     Running   0          15s     10.233.102.138   node1   <none>           <none>
back-8485b7bfbd-l2pcj   1/1     Running   0          4h21m   10.233.102.135   node1   <none>           <none>
back-8485b7bfbd-s52kg   1/1     Running   0          15s     10.233.75.10     node2   <none>           <none>
db-0                    1/1     Running   0          6h18m   10.233.102.133   node1   <none>           <none>
front-59589466b-6p9b6   1/1     Running   0          26s     10.233.102.136   node1   <none>           <none>
front-59589466b-gxq69   1/1     Running   0          26s     10.233.102.137   node1   <none>           <none>
front-59589466b-wpdhb   1/1     Running   0          4h21m   10.233.75.7      node2   <none>           <none>
```
![img_49.png](img_49.png)

<details>
<summary>kubectl describe pods --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe pods --namespace=prod
Name:             back-8485b7bfbd-7w7rp
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 07:09:19 +0300
Labels:           app=back
                  pod-template-hash=8485b7bfbd
Annotations:      cni.projectcalico.org/containerID: 97944b1fd078928db77184b206c05b8cf5e21f41072708fb40a3c1a761062220
                  cni.projectcalico.org/podIP: 10.233.102.138/32
                  cni.projectcalico.org/podIPs: 10.233.102.138/32
Status:           Running
IP:               10.233.102.138
IPs:
  IP:           10.233.102.138
Controlled By:  ReplicaSet/back-8485b7bfbd
Containers:
  back:
    Container ID:   containerd://60d9d08c9b23bcca7280eb34d9c0b20bc18d5c45383199d7bc70f3b5e5979ef0
    Image:          dmi3x3/13-kubernetes-config_backend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_backend@sha256:bf7c946a16631879bd2a047791e11f658bf0ee63a916174c04ec7b79d6ea9337
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 07:09:21 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@postgres.prod.svc.cluster.local:5432/news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4krsm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4krsm:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  111s  default-scheduler  Successfully assigned prod/back-8485b7bfbd-7w7rp to node1
  Normal  Pulling    110s  kubelet            Pulling image "dmi3x3/13-kubernetes-config_backend"
  Normal  Pulled     109s  kubelet            Successfully pulled image "dmi3x3/13-kubernetes-config_backend" in 936.390573ms
  Normal  Created    109s  kubelet            Created container back
  Normal  Started    109s  kubelet            Started container back


Name:             back-8485b7bfbd-l2pcj
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 02:48:16 +0300
Labels:           app=back
                  pod-template-hash=8485b7bfbd
Annotations:      cni.projectcalico.org/containerID: a8e3aa39c2ee6fe84ef23a9f1560e2c72482e01e451913bf936ab9a2adbf3dce
                  cni.projectcalico.org/podIP: 10.233.102.135/32
                  cni.projectcalico.org/podIPs: 10.233.102.135/32
Status:           Running
IP:               10.233.102.135
IPs:
  IP:           10.233.102.135
Controlled By:  ReplicaSet/back-8485b7bfbd
Containers:
  back:
    Container ID:   containerd://13c2da2b4cf0c1ee36a07e60de409483e7a637679cdda19fe224e79fac8cfb4b
    Image:          dmi3x3/13-kubernetes-config_backend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_backend@sha256:bf7c946a16631879bd2a047791e11f658bf0ee63a916174c04ec7b79d6ea9337
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 02:48:18 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@postgres.prod.svc.cluster.local:5432/news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6d2rz (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-6d2rz:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>


Name:             back-8485b7bfbd-s52kg
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node2/10.1.2.33
Start Time:       Thu, 05 Jan 2023 07:09:19 +0300
Labels:           app=back
                  pod-template-hash=8485b7bfbd
Annotations:      cni.projectcalico.org/containerID: 2498f7a8bc3c95c36d40eabc69853583d4242519f6df89ebfb7d40c7c4186fb8
                  cni.projectcalico.org/podIP: 10.233.75.10/32
                  cni.projectcalico.org/podIPs: 10.233.75.10/32
Status:           Running
IP:               10.233.75.10
IPs:
  IP:           10.233.75.10
Controlled By:  ReplicaSet/back-8485b7bfbd
Containers:
  back:
    Container ID:   containerd://aab1efbc1323f8324b4b99f787c2373549aea254bdfede982de78ee0727fe4d0
    Image:          dmi3x3/13-kubernetes-config_backend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_backend@sha256:bf7c946a16631879bd2a047791e11f658bf0ee63a916174c04ec7b79d6ea9337
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 07:09:21 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@postgres.prod.svc.cluster.local:5432/news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-fnzkk (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-fnzkk:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  111s  default-scheduler  Successfully assigned prod/back-8485b7bfbd-s52kg to node2
  Normal  Pulling    110s  kubelet            Pulling image "dmi3x3/13-kubernetes-config_backend"
  Normal  Pulled     109s  kubelet            Successfully pulled image "dmi3x3/13-kubernetes-config_backend" in 993.647228ms
  Normal  Created    109s  kubelet            Created container back
  Normal  Started    109s  kubelet            Started container back


Name:             db-0
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 00:51:19 +0300
Labels:           app=db
                  controller-revision-hash=db-dfc8cd59d
                  statefulset.kubernetes.io/pod-name=db-0
Annotations:      cni.projectcalico.org/containerID: 168ef050707dcff32345c6bbe11fb6f65693b86e873b18137fdb26d8ab0e0b74
                  cni.projectcalico.org/podIP: 10.233.102.133/32
                  cni.projectcalico.org/podIPs: 10.233.102.133/32
Status:           Running
IP:               10.233.102.133
IPs:
  IP:           10.233.102.133
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://9c1e9a43d2a10bf25007158079644b835b97f1ee5b792679c2e27eef831d8fd0
    Image:          postgres:13-alpine
    Image ID:       docker.io/library/postgres@sha256:93924d8dbf68fef91ed3252a956a0668a609fc8a6693c7e4a519b0cca71b9203
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 05 Jan 2023 00:51:20 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_DB:        news
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      PGDATA:             /data/pgdata
    Mounts:
      /data from pv-prod (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zzxrs (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  pv-prod:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pv-prod-db-0
    ReadOnly:   false
  kube-api-access-zzxrs:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>


Name:             front-59589466b-6p9b6
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 07:09:08 +0300
Labels:           app=front
                  pod-template-hash=59589466b
Annotations:      cni.projectcalico.org/containerID: c738f238ca105fd1351471e930c61d88335423b3d96611335fbb504564c8edc7
                  cni.projectcalico.org/podIP: 10.233.102.136/32
                  cni.projectcalico.org/podIPs: 10.233.102.136/32
Status:           Running
IP:               10.233.102.136
IPs:
  IP:           10.233.102.136
Controlled By:  ReplicaSet/front-59589466b
Containers:
  front:
    Container ID:   containerd://0dac3d5a2acf355394490d701dbb3479b01af64dff73ba84dace8a5fe917b158
    Image:          dmi3x3/13-kubernetes-config_frontend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_frontend@sha256:27355ae95dce068c7349fada1c49566b5ccdb89aa0618c4f3b95faf0fff133b1
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 07:09:12 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      BASE_URL:  http://back-svc.prod.svc.cluster.local:9000
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dgmlg (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-dgmlg:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  2m2s  default-scheduler  Successfully assigned prod/front-59589466b-6p9b6 to node1
  Normal  Pulling    2m1s  kubelet            Pulling image "dmi3x3/13-kubernetes-config_frontend"
  Normal  Pulled     119s  kubelet            Successfully pulled image "dmi3x3/13-kubernetes-config_frontend" in 2.203959263s
  Normal  Created    119s  kubelet            Created container front
  Normal  Started    118s  kubelet            Started container front


Name:             front-59589466b-gxq69
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 07:09:08 +0300
Labels:           app=front
                  pod-template-hash=59589466b
Annotations:      cni.projectcalico.org/containerID: d73c431a660c4df28ec8b4e60864d4f1b24a2e81232f80e6adc9591e7c292025
                  cni.projectcalico.org/podIP: 10.233.102.137/32
                  cni.projectcalico.org/podIPs: 10.233.102.137/32
Status:           Running
IP:               10.233.102.137
IPs:
  IP:           10.233.102.137
Controlled By:  ReplicaSet/front-59589466b
Containers:
  front:
    Container ID:   containerd://59693171ebd1239a005b3ccbd15ae92c930a38887ae2c40978f7f34ad63bae7e
    Image:          dmi3x3/13-kubernetes-config_frontend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_frontend@sha256:27355ae95dce068c7349fada1c49566b5ccdb89aa0618c4f3b95faf0fff133b1
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 07:09:10 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      BASE_URL:  http://back-svc.prod.svc.cluster.local:9000
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jwnnj (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-jwnnj:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  2m2s  default-scheduler  Successfully assigned prod/front-59589466b-gxq69 to node1
  Normal  Pulling    2m1s  kubelet            Pulling image "dmi3x3/13-kubernetes-config_frontend"
  Normal  Pulled     2m    kubelet            Successfully pulled image "dmi3x3/13-kubernetes-config_frontend" in 1.148097825s
  Normal  Created    2m    kubelet            Created container front
  Normal  Started    2m    kubelet            Started container front


Name:             front-59589466b-wpdhb
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node2/10.1.2.33
Start Time:       Thu, 05 Jan 2023 02:48:08 +0300
Labels:           app=front
                  pod-template-hash=59589466b
Annotations:      cni.projectcalico.org/containerID: 60f91d0d43b5125fa6f9cc6f3f7a087799312f80c9dff77d8df1947d20382ad3
                  cni.projectcalico.org/podIP: 10.233.75.7/32
                  cni.projectcalico.org/podIPs: 10.233.75.7/32
Status:           Running
IP:               10.233.75.7
IPs:
  IP:           10.233.75.7
Controlled By:  ReplicaSet/front-59589466b
Containers:
  front:
    Container ID:   containerd://6ffac39336556706f2e11cd7315101118d1fca8be7dde3b0eb106515a9922c45
    Image:          dmi3x3/13-kubernetes-config_frontend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_frontend@sha256:27355ae95dce068c7349fada1c49566b5ccdb89aa0618c4f3b95faf0fff133b1
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 02:48:09 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      BASE_URL:  http://back-svc.prod.svc.cluster.local:9000
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-h4cxx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-h4cxx:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```
</details>

<details>
<summary>kubectl describe service --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe service --namespace=prod
Name:              back-svc
Namespace:         prod
Labels:            app=back
Annotations:       <none>
Selector:          app=back
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.41.253
IPs:               10.233.41.253
Port:              9000  9000/TCP
TargetPort:        9000/TCP
Endpoints:         10.233.102.135:9000,10.233.102.138:9000,10.233.75.10:9000
Session Affinity:  None
Events:            <none>


Name:              front-svc
Namespace:         prod
Labels:            <none>
Annotations:       <none>
Selector:          app=front
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.55.66
IPs:               10.233.55.66
Port:              8000  8000/TCP
TargetPort:        80/TCP
Endpoints:         10.233.102.136:80,10.233.102.137:80,10.233.75.7:80
Session Affinity:  None
Events:            <none>


Name:              postgres
Namespace:         prod
Labels:            app=db
Annotations:       <none>
Selector:          app=db
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.21.78
IPs:               10.233.21.78
Port:              5432  5432/TCP
TargetPort:        5432/TCP
Endpoints:         10.233.102.133:5432
Session Affinity:  None
Events:            <none>
```

</details>

### Уменьшил количество реплик front и back до одной:

```shell
kubectl scale --replicas=1 deployment/back --namespace=prod
```

### Поймал момент уничтожения ненужных реплик:

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl get pods --namespace=prod -o wide
NAME                    READY   STATUS        RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
back-8485b7bfbd-7w7rp   1/1     Terminating   0          6m1s    10.233.102.138   node1   <none>           <none>
back-8485b7bfbd-l2pcj   1/1     Terminating   0          4h27m   10.233.102.135   node1   <none>           <none>
back-8485b7bfbd-s52kg   1/1     Running       0          6m1s    10.233.75.10     node2   <none>           <none>
db-0                    1/1     Running       0          6h24m   10.233.102.133   node1   <none>           <none>
front-59589466b-wpdhb   1/1     Running       0          4h27m   10.233.75.7      node2   <none>           <none>
```

### Количество реплик вернулось к первоначальному состоянию, но идентификатор и IP пода back изменился, а под front остался тем же, видимо его id начинается внизу алфавита, а уничтожается сначала. 

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl get pods --namespace=prod -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
back-8485b7bfbd-s52kg   1/1     Running   0          6m36s   10.233.75.10     node2   <none>           <none>
db-0                    1/1     Running   0          6h24m   10.233.102.133   node1   <none>           <none>
front-59589466b-wpdhb   1/1     Running   0          4h27m   10.233.75.7      node2   <none>           <none>
```
![img_50.png](img_50.png)



<details>
<summary>kubectl describe pods --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe pods --namespace=prod
Name:             back-8485b7bfbd-s52kg
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node2/10.1.2.33
Start Time:       Thu, 05 Jan 2023 07:09:19 +0300
Labels:           app=back
                  pod-template-hash=8485b7bfbd
Annotations:      cni.projectcalico.org/containerID: 2498f7a8bc3c95c36d40eabc69853583d4242519f6df89ebfb7d40c7c4186fb8
                  cni.projectcalico.org/podIP: 10.233.75.10/32
                  cni.projectcalico.org/podIPs: 10.233.75.10/32
Status:           Running
IP:               10.233.75.10
IPs:
  IP:           10.233.75.10
Controlled By:  ReplicaSet/back-8485b7bfbd
Containers:
  back:
    Container ID:   containerd://aab1efbc1323f8324b4b99f787c2373549aea254bdfede982de78ee0727fe4d0
    Image:          dmi3x3/13-kubernetes-config_backend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_backend@sha256:bf7c946a16631879bd2a047791e11f658bf0ee63a916174c04ec7b79d6ea9337
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 07:09:21 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@postgres.prod.svc.cluster.local:5432/news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-fnzkk (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-fnzkk:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  9m12s  default-scheduler  Successfully assigned prod/back-8485b7bfbd-s52kg to node2
  Normal  Pulling    9m12s  kubelet            Pulling image "dmi3x3/13-kubernetes-config_backend"
  Normal  Pulled     9m11s  kubelet            Successfully pulled image "dmi3x3/13-kubernetes-config_backend" in 993.647228ms
  Normal  Created    9m11s  kubelet            Created container back
  Normal  Started    9m11s  kubelet            Started container back


Name:             db-0
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node1/10.1.2.16
Start Time:       Thu, 05 Jan 2023 00:51:19 +0300
Labels:           app=db
                  controller-revision-hash=db-dfc8cd59d
                  statefulset.kubernetes.io/pod-name=db-0
Annotations:      cni.projectcalico.org/containerID: 168ef050707dcff32345c6bbe11fb6f65693b86e873b18137fdb26d8ab0e0b74
                  cni.projectcalico.org/podIP: 10.233.102.133/32
                  cni.projectcalico.org/podIPs: 10.233.102.133/32
Status:           Running
IP:               10.233.102.133
IPs:
  IP:           10.233.102.133
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://9c1e9a43d2a10bf25007158079644b835b97f1ee5b792679c2e27eef831d8fd0
    Image:          postgres:13-alpine
    Image ID:       docker.io/library/postgres@sha256:93924d8dbf68fef91ed3252a956a0668a609fc8a6693c7e4a519b0cca71b9203
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 05 Jan 2023 00:51:20 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_DB:        news
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      PGDATA:             /data/pgdata
    Mounts:
      /data from pv-prod (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zzxrs (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  pv-prod:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pv-prod-db-0
    ReadOnly:   false
  kube-api-access-zzxrs:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>


Name:             front-59589466b-wpdhb
Namespace:        prod
Priority:         0
Service Account:  default
Node:             node2/10.1.2.33
Start Time:       Thu, 05 Jan 2023 02:48:08 +0300
Labels:           app=front
                  pod-template-hash=59589466b
Annotations:      cni.projectcalico.org/containerID: 60f91d0d43b5125fa6f9cc6f3f7a087799312f80c9dff77d8df1947d20382ad3
                  cni.projectcalico.org/podIP: 10.233.75.7/32
                  cni.projectcalico.org/podIPs: 10.233.75.7/32
Status:           Running
IP:               10.233.75.7
IPs:
  IP:           10.233.75.7
Controlled By:  ReplicaSet/front-59589466b
Containers:
  front:
    Container ID:   containerd://6ffac39336556706f2e11cd7315101118d1fca8be7dde3b0eb106515a9922c45
    Image:          dmi3x3/13-kubernetes-config_frontend
    Image ID:       docker.io/dmi3x3/13-kubernetes-config_frontend@sha256:27355ae95dce068c7349fada1c49566b5ccdb89aa0618c4f3b95faf0fff133b1
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 05 Jan 2023 02:48:09 +0300
    Ready:          True
    Restart Count:  0
    Environment:
      BASE_URL:  http://back-svc.prod.svc.cluster.local:9000
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-h4cxx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-h4cxx:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```


</details>


<details>
<summary>kubectl describe svc --namespace=prod</summary>

```shell
dmi3x3@dellix:~/netology/devkub-homeworks/13-kubernetes-config$ kubectl describe svc --namespace=prod
Name:              back-svc
Namespace:         prod
Labels:            app=back
Annotations:       <none>
Selector:          app=back
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.41.253
IPs:               10.233.41.253
Port:              9000  9000/TCP
TargetPort:        9000/TCP
Endpoints:         10.233.75.10:9000
Session Affinity:  None
Events:            <none>


Name:              front-svc
Namespace:         prod
Labels:            <none>
Annotations:       <none>
Selector:          app=front
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.55.66
IPs:               10.233.55.66
Port:              8000  8000/TCP
TargetPort:        80/TCP
Endpoints:         10.233.75.7:80
Session Affinity:  None
Events:            <none>


Name:              postgres
Namespace:         prod
Labels:            app=db
Annotations:       <none>
Selector:          app=db
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.233.21.78
IPs:               10.233.21.78
Port:              5432  5432/TCP
TargetPort:        5432/TCP
Endpoints:         10.233.102.133:5432
Session Affinity:  None
Events:            <none>
```

</details>


### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

