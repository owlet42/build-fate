FROM centos:centos7.2.1511

RUN set -eux; \
    rpm --rebuilddb; \
    rpm --import /etc/pki/rpm-gpg/RPM*; \
    yum -y install wget gcc gcc-c++ make openssl-devel supervisor gmp-devel mpfr-devel libmpc-devel libaio numactl autoconf automake libtool libffi-devel snappy snappy-devel zlib zlib-devel bzip2 bzip2-devel lz4-devel libasan lsof; \
    yum clean all;

ENV fate_cos_address https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com
ENV python_version 1.1
ENV jdk_version 8u192

RUN set -eux; \
\
    mkdir -p /data/projects/packages/; \
    cd /data/projects/packages/; \
    wget ${fate_cos_address}/Miniconda3-4.5.4-Linux-x86_64.sh; \
\
    miniconda3_dir=/data/projects/fate/common/python/miniconda3; \
    venv_dir=/data/projects/fate/common/python/venv; \
\
    sh ./Miniconda3-*-Linux-x86_64.sh -b -p ${miniconda3_dir}; \
    rm -f Miniconda3-*-Linux-x86_64.sh; \
\
    wget ${fate_cos_address}/pip-packages-fate-1.1.tar.gz; \
    tar xzf pip-packages-fate-1.1.tar.gz; \
    rm -rf pip-packages-fate-1.1.tar.gz; \
\
    ${miniconda3_dir}/bin/pip install virtualenv -f ./pip-packages-fate-${python_version} --no-index; \
    ${miniconda3_dir}/bin/virtualenv -p ${miniconda3_dir}/bin/python3.6  --no-wheel --no-setuptools --no-download ${venv_dir}; \
    source ${venv_dir}/bin/activate; \
\
    pip install ./pip-packages-fate-1.1/setuptools-41.4.0-py2.py3-none-any.whl; \
\
    wget https://github.com/FederatedAI/FATE/raw/master/requirements.txt; \
    pip install -r ./requirements.txt -f ./pip-packages-fate-1.1 --no-index; \
    pip list | wc -l;



RUN set -eux; \
\
    cd /data/projects/packages/; \
    wget ${fate_cos_address}/jdk-${jdk_version}-linux-x64.tar.gz; \
    tar xzf jdk-${jdk_version}-linux-x64.tar.gz; \
    rm -rf jdk-${jdk_version}-linux-x64.tar.gz; \
    mkdir -p tmp; \
    cp -r jdk*/* tmp; \
    rm -rf jdk*; \
    mv tmp jdk-${jdk_version}; \
    mkdir -p /data/projects/fate/common/jdk/; \
    mv jdk-${jdk_version} /data/projects/fate/common/jdk/jdk-${jdk_version}; \
\
    rm -rf /data/projects/packages/;

ENV JAVA_HOME /data/projects/fate/common/jdk/jdk-${jdk_version}
ENV PATH $JAVA_HOME/bin:$PATH

RUN set -eux; \
    java -version; \
    python -V;