ARG STRIMZI_RELEASE=0.27.1-kafka-3.0.0
FROM quay.io/strimzi/kafka:$STRIMZI_RELEASE

COPY ./bin /opt/kafka/bin/