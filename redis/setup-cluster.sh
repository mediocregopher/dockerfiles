#!/bin/sh

cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ./cluster-conf.sh

if [ "$PREFIX" != "" ]; then
	PREFIX="$PREFIX-"
fi

PORT_OFFSET=$(expr 6379 + $PORT_OFFSET)

# We need to escape and / in ETCD_DIR because it will be used in sed later
SED_ETCD_DIR=$(echo "$ETCD_DIR" | sed 's/\//\\\//g')

cp 'redis-cluster-discovery@.service.tpl' 'redis-cluster-discovery@.service'
cp 'redis-cluster@.service.tpl' 'redis-cluster@.service'
sed -i "s/_ETCD_DIR/$SED_ETCD_DIR/" 'redis-cluster-discovery@.service'
sed -i "s/_PORT_OFFSET/$PORT_OFFSET/" 'redis-cluster@.service'
sed -i "s/_PORT_OFFSET/$PORT_OFFSET/" 'redis-cluster-discovery@.service'

N=$(expr $N - 1)
for i in $(seq 0 $N); do
	fleetctl start "redis-cluster@$PREFIX$i.service"
	fleetctl start "redis-cluster-discovery@$PREFIX$i.service"
	while [ "$(etcdctl get "$ETCD_DIR/redis-cluster-$PREFIX$i" | cut -d':' -f2)" = "" ]; do
		echo "waiting for redis-cluster-$PREFIX$i to get its shit together"
		sleep 1
	done
done

MEMBERS=$(for i in $(seq 0 $N); do
	etcdctl get "$ETCD_DIR/redis-cluster-$PREFIX$i"
done | xargs echo)
echo "Adding members; $MEMBERS"

docker run -it --rm mediocregopher/redis sh -c "yes yes | redis-trib.rb create --replicas $REPLICAS $MEMBERS"
rm 'redis-cluster-discovery@.service'
rm 'redis-cluster@.service'
