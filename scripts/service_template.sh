#!/usr/bin/env bash
set -e
service_name=$1
build_hash=$2
cat <<EOF
[Unit]
Description=${service_name}

[Service]
User=core

ExecStartPre=-/usr/bin/docker kill ${service_name}-%i
ExecStartPre=-/usr/bin/docker rm ${service_name}-%i
ExecStart=/usr/bin/docker run --name ${service_name}-%i -t docker-registry.optiopay.com/${service_name}:${build_hash}

ExecStop=/usr/bin/docker stop ${service_name}-%i

[X-Fleet]
Conflicts=${service_name}@*.service
EOF