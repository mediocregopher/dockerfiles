[Unit]
Description=redis-cluster-discovery-%i
BindsTo=redis-cluster@%i.service

[Service]
Environment=ETCD_DIR=_ETCD_DIR PORT_OFFSET=_PORT_OFFSET
EnvironmentFile=/etc/environment
ExecStart=/bin/sh -c "PORT=$(expr $PORT_OFFSET + $(echo '%i' | sed 's/[^0-9]//g')); \
                      while true; do \
                          etcdctl set \"$ETCD_DIR/redis-cluster-%i\" ${COREOS_PRIVATE_IPV4}:$PORT --ttl 60; \
                          sleep 45; \
                      done"
ExecStop=/bin/sh -c "/usr/bin/etcdctl rm $ETCD_dIR/redis-cluster-%i"

[X-Fleet]
X-ConditionMachineOf=redis-cluster@%i.service
