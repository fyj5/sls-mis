FROM openjdk:8u252-jdk
ENV PROJECT="" \
    ACCESS_KEY_ID="" \
    ACCESS_SECRET="" \
    INSTANCE="" \
    ENDPOINT="" \
    SERVICE_NAME="queue-master" \
    SERVICE_VERSION="1.1.0" \
    DEPLOYMENT_ENVIRONMENT="production"

WORKDIR /sls-mall
COPY target/queue-master.jar ./app.jar
COPY target/opentelemetry-javaagent-all.jar .
COPY startup.sh .
RUN chmod +x startup.sh
EXPOSE 8087
CMD ["/sls-mall/startup.sh"]
