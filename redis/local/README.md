#宿主机添加www用户
```
id redis || useradd  -r -s /sbin/nologin -M  redis

[ -d /www/data/redis ] || mkdir -pv /www/data/redis
chown -R redis:redis /www/data/redis


[root@localhost redis_cluster]# vim /etc/sysctl.conf
vm.overcommit_memory = 1

sysctl -p
echo never > /sys/kernel/mm/transparent_hugepage/enabled

```




#Run 3.2
``` 
docker run --name myredis --rm  -p 6379:6379 --user $(id -u redis) -itd \
-v /www/data/redis:/var/lib/redis \
-v /code/docker/redis/local/conf/redis.conf:/usr/local/etc/redis/redis.conf \
registry.cn-hangzhou.aliyuncs.com/zander84/myredis:3.2.11
```

#Run 5.0.5
``` 
docker run --name myredis505 --rm  -p 6379:6379 --user $(id -u redis) -itd   --privileged \
-v /code/docker/redis/local/conf/redis505.conf:/usr/local/etc/redis/redis.conf \
-v /www/data/redis:/var/lib/redis \
-v /www/data/redis:/data \
--sysctl net.core.somaxconn=65535 \
registry.cn-hangzhou.aliyuncs.com/zander84/myredis:5.0.5
```


#DOC
```
https://hub.docker.com/_/redis?tab=description&page=7
```

#进入虚拟机
```
docker container exec -it /myredis:3.2.11 bash
```
