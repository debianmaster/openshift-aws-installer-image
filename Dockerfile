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
      RUN git clone https://github.com/openshift/openshift-ansible.git
      WORKDIR /ansible/openshift-ansible
      RUN pip install -e git://github.com/lorin/ansible.git#egg=ansible
      ADD hosts /etc/ansible/hosts
      
