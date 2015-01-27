FROM base/archlinux:2014.07.03

WORKDIR /tmp
RUN yes | pacman -Sy make gcc libunistring ruby unzip
RUN gem install redis

ADD https://github.com/antirez/redis/archive/3.0.0-rc2.tar.gz /tmp/redis.tar.gz

RUN tar xf redis.tar.gz && \
    cd redis-3.0.0-rc2 && \
    make && \
    make PREFIX=/usr install

RUN cd redis-3.0.0-rc2 && \
    cp src/redis-trib.rb /usr/bin && \
    echo 'port 6379' > /etc/redis.conf && \
    echo 'cluster-enabled yes' >> /etc/redis.conf && \
    echo 'cluster-config-file nodes.conf' >> /etc/redis.conf && \
    echo 'cluster-node-timeout 15000' >> /etc/redis.conf && \
    echo 'appendonly yes' >> /etc/redis.conf && \
    rm -rf /tmp/redis*

WORKDIR /redisdata
VOLUME /redisdata

CMD [ "/usr/bin/redis-server", "/etc/redis.conf" ]
