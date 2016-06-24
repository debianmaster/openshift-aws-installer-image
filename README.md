

> This container has necessary packages like ansible/python ("the right versions")  to run openshift-ansible scripts located at https://github.com/openshift/openshift-ansible.git


#### Clone repo and add your aws pem file 
```sh
git clone https://github.com/debianmaster/openshift_dev_machine.git 
cd openshift_dev_machine
```
> Copy your aws pem file and rename it to *ck_workshop.pem*   

#### Edit your .env_sample file and rename it to .env
```sh

```

#### Build docker image   
```sh
docker build -t "openshift_dev_machine" .
```

#### Run docker image to start the cluster deployment
```sh
docker run -d --env-file=.env --name ose_install openshift_dev_machine
```

### To see Progress
```sh
docker logs -f ose_install
```

