FROM base/archlinux:2014.07.03

ADD https://github.com/antirez/redis/archive/3.0.0-rc2.tar.gz /tmp/redis.tar.gz

WORKDIR /tmp
RUN yes | pacman -Sy make gcc libunistring
RUN tar xf redis.tar.gz && \
    cd redis-3* && \
    make && \
    make PREFIX=/usr install && \
    cp redis.conf sentinel.conf /etc && \
    cd / && \
    rm -rf /tmp/redis*

EXPOSE 6379
WORKDIR /redisdata
VOLUME /redisdata

CMD [ "/usr/bin/redis-server", "/etc/redis.conf" ]
