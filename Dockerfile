      FROM centos:centos7
      MAINTAINER Mateusz Pawlowski 
      RUN yum clean all && \
      yum -y install epel-release && \
      yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip \
      yum install rubygem-thor rubygem-parseconfig util-linux pyOpenSSL libffi-devel python-cryptography
      RUN mkdir /etc/ansible/
      RUN echo "[local]" > /etc/ansible/hosts ; echo "localhost" >> /etc/ansible/hosts
      RUN mkdir /opt/ansible/ -p
      RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
      WORKDIR /opt/ansible/ansible
      RUN git checkout v1.9.4-1
      RUN git submodule update --init
      ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
      ENV PYTHONPATH /opt/ansible/ansible/lib
      ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
      RUN mkdir /ansible
      WORKDIR /ansible
      RUN pip install -e git://github.com/lorin/ansible.git#egg=ansible
      RUN pip install boto && pip install click
      ADD hosts /etc/ansible/hosts
      WORKDIR /
      RUN mkdir ansible-scripts && \
cd ansible-scripts && \ 
git clone https://github.com/2015-Middleware-Keynote/demo-ansible.git && \
cd demo-ansible && \
git checkout demo-ansible-2.1.2 && \
cd .. && \
git clone https://github.com/openshift/openshift-ansible.git && \
cd openshift-ansible && \
git fetch origin :remotes/origin/openshift-ansible-3.0.47-6 && \
git checkout openshift-ansible-3.0.47-6 && \
cd ../demo-ansible 
     WORKDIR /ansible-scripts/demo-ansible
     ADD ck_workshop.pem .
     ADD run.sh .
     RUN chmod 400 ck_workshop.pem && chmod +x run.sh
     RUN sed -i 's/ose-3.1/ose-3.2/g'  playbooks/subscriptions_and_repos.yml && \
sed -i 's/1.8.2/1.9.1/g' ./playbooks/openshift_setup.yml && \
sed -i 's/3.1.1.6/3.2.0.44/g' ./playbooks/openshift_setup.yml && \
sed -i 's/ose-3.1/ose-3.2/g' ./playbooks/register_host.yml && \
sed -i 's/enterprise-3.1.1.6/enterprise-3.2.0.44/g' ./playbooks/templates/aos.repo.j2
     CMD ssh-agent ./run.sh
   
