
# Number of nodes to spin up. Must be an even number which is greater than or
# equal to 3
N=6

# Number of replicas per master node in the cluster. e.g. if N=6 and REPLICAS=1,
# then there will be 3 master nodes and 3 slave nodes
REPLICAS=1

# Number which will be used as an offset when determining a port number for a
# cluster instance. The port number of each instance is determined as:
# 6379 + PORT_OFFSET + N
PORT_OFFSET=0

# Prefix to add to the numbering of each instance. With PREFIX not set each
# instance will be named "redis-cluster-$N", with it set each will be named
# "redis-cluster-$PREFIx-$N". PREFIX must only contain letters, underscores, or
# dashes
PREFIX=

# Directory in etcd to create service discovery files in. Each one will be
# called "redis-cluster-[$PREFIX-]$N", which will have the host:port of the
# redis instance
ETCD_DIR="/services"
