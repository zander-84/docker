FROM redis:5.0.5

MAINTAINER zander


COPY conf/redis.conf /usr/local/etc/redis/redis.conf

RUN  mkdir /var/log/redis/ && chmod -R 777 /var/log/redis/



CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]



