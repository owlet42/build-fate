FROM centos:centos7.2.1511

ENV fate_version v1.1

WORKDIR /data/projects

RUN set -eux; \
    rpm --rebuilddb; \
    rpm --import /etc/pki/rpm-gpg/RPM*; \
    yum -y install wget git; \
    yum clean all;

RUN set -eux; \
    git clone -b ${fate_version} https://github.com/FederatedAI/FATE.git;\
    cd cd FATE/cluster-deploy/scripts;\
    bash packaging.sh;\
    
    