#!/bin/sh

for i in $(seq 0 11); do
        fleetctl start redis-cluster@$i.service
        fleetctl start redis-cluster-discovery@$i.service
done

sleep 60

MEMBERS=$(for i in $(seq 0 11); do
        etcdctl get /services/redis-cluster-$i
done | xargs echo)
echo "Adding members; $MEMBERS"

yes yes | docker run -it --rm mediocregopher/redis redis-trib.rb create $MEMBERS
