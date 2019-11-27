FROM mcr.microsoft.com/java/jre:8u192-zulu-alpine

WORKDIR /data/projects/fate/federation

RUN set -eux; \
	\
	wget https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/fate-federation-1.1.tar.gz; \
    \
    tar -xzf fate-federation-1.1.tar.gz; \
    rm fate-federation-1.1.tar.gz; \
    ln -s fate-federation-1.1.jar fate-federation.jar;
    
EXPOSE 9394

CMD cd /data/projects/fate/federation && \
    java -cp "conf/:lib/*:fate-federation.jar" com.webank.ai.fate.driver.Federation -c conf/federation.properties
