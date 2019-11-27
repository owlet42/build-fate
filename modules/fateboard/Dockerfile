FROM mcr.microsoft.com/java/jre:8u192-zulu-alpine

WORKDIR /data/projects/fate

RUN set -eux; \
	\
	wget https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/fateboard-1.1.jar; 

EXPOSE 8080

CMD cd /data/projects/fate/fateboard && \
    java -Dspring.config.location=/data/projects/fate/fateboard/conf/application.properties  -Dssh_config_file=/data/projects/fate/fateboard/conf  -Xmx2048m -Xms2048m -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:gc.log -XX:+HeapDumpOnOutOfMemoryError  -jar fateboard-1.1.jar
