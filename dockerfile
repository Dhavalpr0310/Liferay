FROM openjdk:11-jdk-slim

ENV LIFERAY_HOME=/opt/liferay
ENV JAVA_OPTS="-Xmx2g -Xms2g -XX:MaxPermSize=512m"

RUN mkdir -p $LIFERAY_HOME

COPY liferay.tar.gz /opt/liferay/

WORKDIR $LIFERAY_HOME

# Install Minikube and Docker
RUN apt-get update && apt-get install -y \
    unzip curl apt-transport-https docker.io && \
    curl -LO https://storage.googleapis.com/minikube/releases/v1.35.0/minikube-linux-amd64 && \
    chmod +x minikube-linux-amd64 && \
    mv minikube-linux-amd64 /usr/local/bin/minikube && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure Minikube to use Docker driver
RUN minikube config set driver docker

# Unpack and configure Liferay
RUN tar -xzf /opt/liferay/liferay.tar.gz -C $LIFERAY_HOME && \
    ls -l $LIFERAY_HOME && \
    mv $LIFERAY_HOME/liferay-portal/* $LIFERAY_HOME/ && \
    rm -rf $LIFERAY_HOME/liferay-portal

RUN chmod -R 777 $LIFERAY_HOME

EXPOSE 8080

CMD ["sh", "./tomcat/bin/catalina.sh", "run"]
