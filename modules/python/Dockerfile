# runtime envrionment
ARG PREFIX=prefix
ARG BASE_TAG=tag
FROM ${PREFIX}/base-image:${BASE_TAG}

COPY  . /data/projects/fate/python/

ENV fate_cos_address https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com
ENV version 1.1

RUN set -eux; \
\
    mkdir -p /data/projects/fate/eggroll/python/eggroll/api ; \
    cd /data/projects/fate/eggroll/python/eggroll/api ; \
    wget ${fate_cos_address}/eggroll-api-${version}.tar.gz; \
    tar -xvf eggroll-api-${version}.tar.gz ; \
    rm eggroll-api-${version}.tar.gz

WORKDIR /data/projects/fate/python

ENV venv /data/projects/fate/common/python/venv
ENV PYTHONPATH /data/projects/fate/python:/data/projects/fate/eggroll/python

CMD source ${venv}/bin/activate && cd fate_flow && python fate_flow_server.py