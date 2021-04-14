#!/usr/bin/env sh
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=${ENDPOINT}
export OTEL_EXPORTER_OTLP_COMPRESSION=gzip
export OTEL_EXPORTER_OTLP_HEADERS=x-sls-otel-project=${PROJECT},x-sls-otel-instance-id=${LOGSTORE},x-sls-otel-ak-id=${ACCESS_KEY_ID},x-sls-otel-ak-secret=${ACCESS_KEY_SECRET}

function checkParam() {
  if [ "$1" = "" ]; then
    echo "Miss [$2] environment parameter"
    exit
  fi
}

checkParam "${ACCESS_KEY_ID}" "ACCESS_KEY_ID" && checkParam "$ACCESS_KEY_SECRET" "ACCESS_KEY_SECRET" && checkParam "$PROJECT" "PROJECT" &&
  checkParam "${LOGSTORE}" "LOGSTORE" && checkParam "${ENDPOINT}" "ENDPOINT"

if [ ! -f "${DEPLOY_HOME}/opentelemetry-javaagent-all.jar" ]; then
  echo "Miss opentelemetry java agent. You can rebuild the image to fix this problem."
  exit 0
fi

echo "RUNNING PARAMETERES: "
echo "- ACCESS_KEY_ID: ${ACCESS_KEY_ID}"
echo "- ACCESS_KEY_SECRET: ${ACCESS_KEY_SECRET}"
echo "- PROJECT: $PROJECT"
echo "- LOGSTORE: $LOGSTORE"
echo "- ENDPOINT: $ENDPOINT"
echo "- SERVICE_NAME: $SERVICE_NAME"
echo "- SERVICE_VERSION: $SERVICE_VERSION"
echo "- SERVICE_HOST: $SERVICE_HOST"

java -javaagent:${DEPLOY_HOME}/opentelemetry-javaagent-all.jar -Dotel.resource.attributes=service.name=${SERVICE_NAME},service.version=${SERVICE_VERSION},host.name=${SERVICE_HOST} -jar ${DEPLOY_HOME}/opentelemetry-java.jar
