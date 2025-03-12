
FROM openjdk:11-jdk-slim

ENV LIFERAY_HOME=/opt/liferay
ENV JAVA_OPTS="-Xmx2g -Xms2g -XX:MaxPermSize=512m"

RUN mkdir -p $LIFERAY_HOME

COPY download/liferay.tar.gz /opt/liferay/

WORKDIR $LIFERAY_HOME

RUN apt-get update && apt-get install -y \
    unzip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN tar -xzf /opt/liferay/liferay.tar.gz -C $LIFERAY_HOME && \
    ls -l $LIFERAY_HOME && \
    mv $LIFERAY_HOME/liferay-portal/* $LIFERAY_HOME/ && \
    rm -rf $LIFERAY_HOME/liferay-portal

    RUN chmod -R 777 $LIFERAY_HOME

EXPOSE 8080

CMD ["sh", "./tomcat/bin/catalina.sh", "run"]
