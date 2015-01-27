[Unit]
Description=redis-cluster
After=docker.service

[Service]
TimeoutStartSec=0
Environment=PORT_OFFSET=_PORT_OFFSET
ExecStartPre=-/usr/bin/docker create --name %p-%i-data mediocregopher/redis true
ExecStartPre=-/usr/bin/docker start %p-%i-data
ExecStartPre=-/usr/bin/docker stop %p-%i
ExecStartPre=-/usr/bin/docker rm %p-%i
ExecStart=/bin/sh -c 'PORT=$(expr $PORT_OFFSET + $(echo %i | sed "s/[^0-9]//g")); \
                      CPORT=$(expr $PORT + 10000); \
                      /usr/bin/docker run --name %p-%i --rm --volumes-from %p-%i-data -p $PORT:$PORT -p $CPORT:$CPORT mediocregopher/redis \
                          sh -c "sed -i s/6379/$PORT/ /etc/redis.conf; \
                          redis-server /etc/redis.conf"'
ExecStop=/usr/bin/docker stop %p-%i
