#!/bin/sh

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ./cluster-conf.sh

fleetctl list-unit-files | grep redis-cluster | grep "$PREFIX" | awk '{print $1}' | xargs -n1 fleetctl destroy
sleep 2
docker ps -a | grep mediocregopher/redis | grep "$PREFIX" | awk '{print $1}' | xargs -n1 docker stop
docker ps -a | grep mediocregopher/redis | grep "$PREFIX" | awk '{print $1}' | xargs -n1 docker rm
