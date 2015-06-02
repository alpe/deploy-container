FROM ubuntu:trusty

# Install Kafka
RUN apt-get update && apt-get install -y unzip openjdk-6-jdk wget curl git docker.io jq

RUN wget -q http://apache.mirrors.spacedump.net/kafka/0.8.1.1/kafka_2.8.0-0.8.1.1.tgz -O /tmp/kafka_2.8.0-0.8.1.1.tgz && \
    tar xfz /tmp/kafka_2.8.0-0.8.1.1.tgz -C /opt && \
    rm /tmp/kafka_2.8.0-0.8.1.1.tgz

ENV PATH="/opt/kafka_2.8.0-0.8.1.1/bin:$PATH"


# Install fleet client
ENV FLEET_VERSION 0.9.0
ENV FLEETCTL_ENDPOINT http://127.0.0.1:4001

RUN curl -LOks https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    tar zxvf fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    cp fleet-v${FLEET_VERSION}-linux-amd64/fleetctl /usr/local/bin/fleetctl && \
    rm -rf fleet-v* && \
    chmod +x /usr/local/bin/fleetctl


# ENTRYPOINT ["/fleetctl"]