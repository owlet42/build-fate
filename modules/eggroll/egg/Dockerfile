ARG PREFIX=prefix
ARG BASE_TAG=tag
FROM ${PREFIX}/base-image:${BASE_TAG}

ENV fate_cos_address https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com
ENV python_version 1.1
ENV jdk_version 8u192
ENV version 1.1



RUN set -eux; \
    \
    rpm --rebuilddb; \
    yum install -y which; \
    \
    mkdir -p /data/projects/fate/source/eggroll; \
    cd  /data/projects/fate/source/eggroll ; \
    mkdir -p ./egg-manager; \
    cd ./egg-manager; \
    wget ${fate_cos_address}/eggroll-egg-${version}.tar.gz; \
    tar xzf eggroll-egg-1.1.tar.gz; \
    rm -f eggroll-egg-1.1.tar.gz; \
    cd ../
    
RUN set -eux; \
    \
    mkdir -p /data/projects/fate/source/eggroll/egg-services; \
    cd /data/projects/fate/source/eggroll/egg-services; \
    \
    mkdir storage-service-cxx; \
    cd storage-service-cxx; \
    \
    wget ${fate_cos_address}/eggroll-storage-service-cxx-${version}.tar.gz; \
    tar xzf eggroll-storage-service-cxx-1.1.tar.gz; \
    rm -rf eggroll-storage-service-cxx-1.1.tar.gz
    
RUN set -eux; \
    cd /data/projects/fate/source/eggroll/egg-services/storage-service-cxx; \
    wget ${fate_cos_address}/third_party_eggrollv1.tar.gz; \
    tar xzf third_party_eggrollv1.tar.gz; \
    rm -rf third_party_eggrollv1.tar.gz; \
    cd ../
    
RUN set -eux; \
    cd /data/projects/fate/source/eggroll/egg-services; \
    mkdir computing; \
    cd computing; \
    wget ${fate_cos_address}/eggroll-computing-${version}.tar.gz; \
    tar xzf eggroll-computing-1.1.tar.gz; \
    rm -rf eggroll-computing-1.1.tar.gz; \
    cd ../
    
RUN set -eux; \
    cd /data/projects/fate/source/eggroll/egg-services; \
    mkdir eggroll-api; \
    cd eggroll-api; \
    wget ${fate_cos_address}/eggroll-api-${version}.tar.gz; \
    tar xzf eggroll-api-1.1.tar.gz; \
    rm -rf eggroll-api-1.1.tar.gz; \
    cd ../
    
RUN set -eux; \
    cd /data/projects/fate/source/eggroll/egg-services; \  
    mkdir eggroll-conf; \
    cd eggroll-conf; \
    wget ${fate_cos_address}/eggroll-conf-${version}.tar.gz; \
    tar xzf eggroll-conf-1.1.tar.gz; \
    rm -rf eggroll-conf-1.1.tar.gz; \
    cd ../

RUN set -eux; \
    mkdir -p /data/projects/fate/eggroll/egg; \
    cp -r /data/projects/fate/source/eggroll/egg-manager/* /data/projects/fate/eggroll/egg/; \
\
    cd /data/projects/fate/eggroll/egg/; \
    ln -s eggroll-egg-1.1.jar eggroll-egg.jar; \
    \
    cd /data/projects/fate/source/eggroll/egg-services; \
    \
    mkdir -p /data/projects/fate/eggroll/storage-service-cxx; \
    cp -r ./storage-service-cxx/* /data/projects/fate/eggroll/storage-service-cxx/; \
    \
    mkdir -p /data/projects/fate/eggroll/python/eggroll/computing; \
    cp -r ./computing/* /data/projects/fate/eggroll/python/eggroll/computing/; \
    \
    mkdir -p /data/projects/fate/eggroll/python/eggroll/api; \
    cp -r ./eggroll-api/* /data/projects/fate/eggroll/python/eggroll/api/; \
    \
    mkdir -p /data/projects/fate/eggroll/python/eggroll/conf; \
    cp -r ./eggroll-conf/* /data/projects/fate/eggroll/python/eggroll/conf/

RUN set -eux; \
    \
    cd /data/projects/fate/eggroll/storage-service-cxx; \
	sed -i.bak "20s#-I. -I.*#-I. -I/data/projects/fate/eggroll/storage-service-cxx/third_party/include#g" ./Makefile; \
	sed -i.bak "34s#LDFLAGS += -L.*#LDFLAGS += -L/data/projects/fate/eggroll/storage-service-cxx/third_party/lib -llmdb -lboost_system -lboost_filesystem -lglog -lgpr#g" ./Makefile; \
	sed -i.bak "36s#PROTOC =.*#PROTOC = /data/projects/fate/eggroll/storage-service-cxx/third_party/bin/protoc#g" ./Makefile; \
	sed -i.bak "37s#GRPC_CPP_PLUGIN =.*#GRPC_CPP_PLUGIN = /data/projects/fate/eggroll/storage-service-cxx/third_party/bin/grpc_cpp_plugin#g" ./Makefile; \
	make; \
    \
    rm -rf /data/projects/fate/source

CMD cd /data/projects/fate/eggroll/storage-service-cxx && \
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/data/projects/fate/eggroll/storage-service-cxx/third_party/lib && \
	export GLOG_log_dir=/data/projects/fate/eggroll/logs/storage-service-cxx && \
    mkdir -p logs /data/projects/fate/eggroll/logs/storage-service-cxx && \
    ./storage-service -p 7778 -d /data/projects/fate/eggroll/data-dir >> logs/console.log 2>>logs/error.log & \
    cd /data/projects/fate/eggroll/egg/ && \
    java -cp "conf/:lib/*:eggroll-egg-1.1.jar" com.webank.ai.eggroll.framework.egg.Egg -c conf/egg.properties