FROM mcr.microsoft.com/java/jre:8u192-zulu-alpine

WORKDIR /data/projects/fate

RUN set -eux; \
	\
	wget https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/eggroll-roll-1.1.tar.gz; \
    \
    tar -xzf eggroll-roll-1.1.tar.gz; \
    rm eggroll-roll-1.1.tar.gz; \
    ln -s eggroll-roll-1.1.jar fate-roll.jar;
EXPOSE 8011
CMD cd roll && \
    java -cp "conf/:lib/*:fate-roll.jar" com.webank.ai.eggroll.framework.Roll -c conf/roll.properties