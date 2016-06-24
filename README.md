

> This container has necessary packages like ansible/python ("the right versions")  to run openshift-ansible scripts located at https://github.com/openshift/openshift-ansible.git


#### Clone repo and add your aws pem file 
```sh
git clone https://github.com/debianmaster/openshift-aws-installer-image.git
cd openshift-aws-installer-image
```
> Copy your aws pem file and rename it to *ck_workshop.pem*   

#### Edit your .env_sample file and rename it to .env
```sh
AWS_ACCESS_KEY_ID=XXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXX
cluser_id=cloud
num_nodes=2
rhsm_pass=XXXXXXXX
rhsm_user=XXXXXXX
ami=ami-2051294a
zone=us-east-1
node_type=r3.xlarge
master_type=t2.large
infra_type=c3.xlarge
users_count=40
```

#### Build docker image   
```sh
docker build -t "ose_installer" .
```

#### Run docker image to start the cluster deployment
```sh
docker run -d --env-file=.env --name ose_install ose_installer
```

### To see Progress
```sh
docker logs -f ose_install
```

### To Delete the cluster
> Goto aws Cloudformation and delete the stack that is created as part of this install 


