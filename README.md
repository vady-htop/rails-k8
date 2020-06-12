### Prerequisite:
Make sure you have installed following packages on your local machine.
1. [MiniKube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
2. [Helm3]https://helm.sh/docs/intro/install/)


### Setting up K8 cluster and install Jenkins

### Make the file executable

 `$ chmod +x k8boot.sh`

### Run script

 `$ ./k8boot.sh`

### Check if pods are up:

```
$ kubectl get pods
NAME                       READY   STATUS    RESTARTS   AGE
jenkins-566f7f9c6b-sh6c5   2/2     Running   0          29m
```

Once pods are up go to www.jenkins.dev.com and login with credentials.

- After logging in create new credentials by going to credentials -> (global) ->  Add Credentials.
- Enter the  DockerHub credentails with id as `dockerHub`.


### Create Job:
- Go to home page and add click on  create new jobs -> enter the new job name and select `Multibranch Pipeline` and click Ok.
- Click on `Configure the project`
- Click on Addsource -> Branch Sources -> Click enter URL as `https://github.com/vady-htop/rails-k8.git`
- Declairative Pipleline will be created and it will deploy cassandra and rails app
