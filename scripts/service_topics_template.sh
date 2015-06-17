#!/usr/bin/env bash
set -e
service_name=$1
build_hash=$2

cat <<EOF
[Unit]
Description=${service_name}-topics
Before=${service_name}-${build_hash}@*.service

[Service]
User=core
Type=oneshot
Environment=release=latest

ExecStartPre=-/usr/bin/docker kill ${service_name}-topics
ExecStartPre=-/usr/bin/docker rm ${service_name}-topics
ExecStartPre=/usr/bin/docker pull docker-registry.optiopay.com/kafka-manager:${release}
ExecStart=/usr/bin/docker run --read-only --name ${service_name}-topics docker-registry.optiopay.com/kafka-manager:${release} \
  '/opt/scripts/create_topics.sh' '${service_name}' 'zookeeper.skydns.local:2181'


[X-Fleet]
Conflicts=${service_name}-topics
EOF