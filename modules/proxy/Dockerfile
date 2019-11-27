FROM mcr.microsoft.com/java/jre:8u192-zulu-alpine

WORKDIR /data/projects/fate/proxy

RUN set -eux; \
	\
	wget https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/fate-proxy-1.1.tar.gz; \
    \
    tar -xzf fate-proxy-1.1.tar.gz && \
    rm fate-proxy-1.1.tar.gz && \
    ln -s fate-proxy-1.1.jar fate-proxy.jar

EXPOSE 9370

CMD cd /data/projects/fate/proxy && \
    java -cp "conf/:lib/*:fate-proxy.jar" com.webank.ai.fate.networking.Proxy -c conf/proxy.properties