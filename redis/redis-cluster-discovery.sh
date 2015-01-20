#!/bin/sh

PORT=$(/usr/bin/docker inspect -f '{{(index (index .NetworkSettings.Ports "6379/tcp") 0).HostPort}}' redis-cluster-$1)
etcdctl set /services/redis-cluster-$1 ${COREOS_PRIVATE_IPV4}:$PORT --ttl 60
