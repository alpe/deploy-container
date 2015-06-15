FROM ubuntu:trusty

MAINTAINER Alex Peters <ap@optiopay.com>

RUN apt-get update && apt-get install -y curl openssh-client

# Install fleet client
ENV FLEET_VERSION 0.10.1

RUN curl -LOks https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    tar zxvf fleet-v${FLEET_VERSION}-linux-amd64.tar.gz && \
    cp fleet-v${FLEET_VERSION}-linux-amd64/fleetctl /usr/local/bin/fleetctl && \
    rm -rf fleet-v* && \
    chmod +x /usr/local/bin/fleetctl

COPY scripts /opt/scripts
COPY fleetctl /root/.fleetctl

VOLUME /opt/scripts/out
VOLUME /src

# Fleet command line client 
ENV FLEETCTL_TUNNEL ""
ENV FLEETCTL_STRICT_HOST_KEY_CHECKING=true
ENV FLEETCTL_ENDPOINT http://127.0.0.1:4001

ENV NUMBER_SERVICE_INSTANCES=1

WORKDIR /opt/scripts