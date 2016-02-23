> This container has necessary packages like ansible/python ("the right versions")  to run openshift-ansible scripts located at https://github.com/openshift/openshift-ansible.git

#### Example steps to create a master, node on Google cloud engine
Say you have two google cloud servers one master and another node like this
* master.openshift.i63.io  
* node.openshift.i63.io

#### Clone repo and build docker image
`git clone https://github.com/debianmaster/openshift_dev_machine.git`  
`cd openshift_dev_machine`  
`docker build -t "openshift_dev_machine" .`  


#### ssh into container and copy  rsa public key to gce servers mentioned above
`docker run -it openshift_dev_machine sh`  
`ssh-keygen`  
> Note:  when you provision your gce server it might not have enabled ssh root login via public keys, make sure you enable them in sshd configuration and restart sshd service
`vi /etc/ssh/sshd_config`  
```sh
  #uncomment
  PermitRootLogin yes
```


#### edit your host files and run ansible scripts 
`vi /etc/ansible/hosts`  
> edit your master and node file references  

`ansible-playbook playbooks/byo/config.yml`  

> Command above should setup your master/node openshift instances


`
