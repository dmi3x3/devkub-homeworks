# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods


## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)


## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

# Ответ:

## Задание 1: Запуск пода из образа в деплойменте

пример из hello world запущен в качестве deployment

```shell
dmitriy@dellix:~$ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4 --replicas=2
deployment.apps/hello-node created
```

Количество реплик в deployment установлено в 2

```shell
dmitriy@dellix:~$ kubectl get po -l app=hello-node --no-headers| wc -l
2
dmitriy@dellix:~$ kubectl get po -l app=hello-node
NAME                         READY   STATUS    RESTARTS   AGE
hello-node-697897c86-222c4   1/1     Running   0          4h1m
hello-node-697897c86-skrkj   1/1     Running   0          4h1m
```
Наличие deployment можно проверить командой kubectl get deployment:

```shell
dmitriy@dellix:~$ kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   2/2     2            2           39s
```
Наличие подов можно проверить командой kubectl get pods:

```shell
dmitriy@dellix:~$ kubectl get pods
NAME                         READY   STATUS    RESTARTS   AGE
hello-node-697897c86-222c4   1/1     Running   0          54s
hello-node-697897c86-skrkj   1/1     Running   0          54s
```

## Задание 2: Просмотр логов для разработки

Создаю пользователя (сервис аккаунт):

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl create serviceaccount devel-read
serviceaccount/devel-read created
```

Создаю роль с указанными действиями (verbs):

```shell
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: devel_read
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods", "pods/log", "pods/describe"]
  verbs: ["get", "list", "watch", "logs", "describe"]
EOF
```

![img_4.png](img_4.png)

Создаю привязку роли к пользователю:

```shell
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "user" to read pods in the "default" namespace.
# You need to already have a Role named "devel_read" in that namespace.
kind: RoleBinding
metadata:
  name: devel_read
  namespace: default
subjects:
- kind: ServiceAccount
  name: devel-read # "name" is case sensitive
  namespace: default
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: devel_read # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
EOF
```
![img_5.png](img_5.png)

Созадаю новый токен доступа для пользователя:

```shell
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: devel-read-token
  annotations:
    kubernetes.io/service-account.name: devel-read
type: kubernetes.io/service-account-token
EOF
```

Посмотрим, токены в сервис аккаунте:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl describe serviceaccounts devel-read 
Name:                devel-read
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              devel-read-token
Events:              <none>
```

Посмотреть сам токен, можно следующей командой:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl get secrets devel-read-token -o jsonpath={.data.token} | base64 --decode
eyJhbGciOiJSUzI1NiIsImtpZCI6IlpnMEtDMG1sUXNfQWpDaTFWU0Z4V3p3OFZOVFBGTHFjU1Y5WWloZW82S28ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRldmVsLXJlYWQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGV2ZWwtcmVhZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjRlNjIxOTM5LTYwYzEtNDFiMy1iZGIxLTFiZjkwZGRjMmRkOSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRldmVsLXJlYWQifQ.K8KUYdykaY9eNuxf2cOTXZv352kUwSOGCYwD7ZFoLNZHQFIWBVYw70sZssPE5VLSpqVYYI6KbwSEcT41QVXmVrpjhS4dpFsWCdSsHjq-UwXxzzMVvwspOeu78sVbCJ_4yk-pSWzI0xmVOMzQ9_9ddMlCeHgFNM0t_2ev_ckH6C_c0YivI1BqvbDT3-8yDdaJxTwl1IURu9Ill1nURR1Y6vhyBI88jq5edZWxxkYJgNIEt6b4Bn5O1a1RIjpybdDQmqfCTWIBLy9s5EbF7rjLV1mMHaGmFnUrjKUEmogqMiAqGZ0cpPDid_OJ8D-9oNe2TiywRhRhXRmFipvk8Z58_w
```

Пропишем пользователя с токеном в локальный конфиг (~/.kube/config, блок users)

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ TOKEN_DEVEL_READ=$(kubectl get secrets devel-read-token -o jsonpath={.data.token} | base64 --decode); kubectl config set-credentials devel-read --token $TOKEN_DEVEL_READ
User "devel-read" set.
```

Переключимся на пользователя:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl config set-context minikube --user devel-read
Context "minikube" modified.
```

Пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)
 
Смотрю логи:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl logs hello-node-697897c86-222c4 
172.17.0.1 - - [30/Dec/2022:20:54:02 +0000] "GET / HTTP/1.1" 200 395 "-" "curl/7.68.0"
172.17.0.1 - - [30/Dec/2022:20:54:46 +0000] "GET / HTTP/1.1" 200 801 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
172.17.0.1 - - [30/Dec/2022:20:54:46 +0000] "GET /favicon.ico HTTP/1.1" 200 730 "http://10.168.1.158:38080/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
172.17.0.1 - - [30/Dec/2022:20:54:50 +0000] "GET / HTTP/1.1" 200 801 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
172.17.0.1 - - [30/Dec/2022:20:54:50 +0000] "GET /favicon.ico HTTP/1.1" 200 730 "http://10.168.1.158:38080/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl logs pods/hello-node-697897c86-222c4 
172.17.0.1 - - [30/Dec/2022:20:54:02 +0000] "GET / HTTP/1.1" 200 395 "-" "curl/7.68.0"
172.17.0.1 - - [30/Dec/2022:20:54:46 +0000] "GET / HTTP/1.1" 200 801 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
172.17.0.1 - - [30/Dec/2022:20:54:46 +0000] "GET /favicon.ico HTTP/1.1" 200 730 "http://10.168.1.158:38080/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
172.17.0.1 - - [30/Dec/2022:20:54:50 +0000] "GET / HTTP/1.1" 200 801 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"
```
Смотрю поды:

![img_6.png](img_6.png)

<details>
<summary>kubectl describe pod hello-node-697897c86-222c4</summary>

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl describe pod hello-node-697897c86-222c4 
Name:             hello-node-697897c86-222c4
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.39.155
Start Time:       Wed, 28 Dec 2022 06:37:11 +0300
Labels:           app=hello-node
                  pod-template-hash=697897c86
Annotations:      <none>
Status:           Running
IP:               172.17.0.3
IPs:
  IP:           172.17.0.3
Controlled By:  ReplicaSet/hello-node-697897c86
Containers:
  echoserver:
    Container ID:   docker://d25b777b001cf4bbd52716d0790ac7671c0f4b4d868e775073eb1bf5356bfe72
    Image:          k8s.gcr.io/echoserver:1.4
    Image ID:       docker-pullable://k8s.gcr.io/echoserver@sha256:5d99aa1120524c801bc8c1a7077e8f5ec122ba16b6dda1a5d3826057f67b9bcb
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 28 Dec 2022 06:37:26 +0300
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-k9jtm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-k9jtm:
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


Поробую посмотреть, например сервисы:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl get service
Error from server (Forbidden): services is forbidden: User "system:serviceaccount:default:devel-read" cannot list resource "services" in API group "" in the namespace "default"
```
Как и ожидалось "Нет доступа"

Переключаюсь на пользователя minikube:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl config set-context minikube --user minikube
Context "minikube" modified.
````

## Задание 3: Изменение количества реплик

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl scale --replicas=5 deployment/hello-node
deployment.apps/hello-node scaled
```
Проверяю, все поды выполняются:

```shell
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl get pod
poddisruptionbudgets.policy  pods                         podtemplates                 
dmitriy@dellix:~/netology/devkub-homeworks$ kubectl get pods 
NAME                         READY   STATUS    RESTARTS   AGE
hello-node-697897c86-222c4   1/1     Running   0          2d17h
hello-node-697897c86-857c4   1/1     Running   0          31s
hello-node-697897c86-jqr9k   1/1     Running   0          31s
hello-node-697897c86-m998g   1/1     Running   0          31s
hello-node-697897c86-skrkj   1/1     Running   0          2d17h
```

Поймал момент, когда контейнеры создаются:
![img_7.png](img_7.png)

---


### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

