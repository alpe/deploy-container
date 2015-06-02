FROM ubuntu:trusty

MAINTAINER Alex Peters <ap@optiopay.com>

RUN apt-get update && apt-get install -y curl openssh-client

# Install fleet client
ENV FLEET_VERSION 0.10.1
ENV FLEETCTL_ENDPOINT http://127.0.0.1:4001

RUN curl -LOks https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    tar zxvf fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    cp fleet-v${FLEET_VERSION}-linux-amd64/fleetctl /usr/local/bin/fleetctl && \
    rm -rf fleet-v* && \
    chmod +x /usr/local/bin/fleetctl

COPY scripts /opt/scripts
COPY fleetctl /root/.fleetctl

VOLUME /opt/scripts/out

ENV topic_replication_factor=2

WORKDIR /opt/scripts