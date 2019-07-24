#宿主机添加www用户
```
id redis || useradd  -r -s /sbin/nologin -M  redis

[ -d /www/data/redis ] || mkdir -pv /www/data/redis
chown -R redis:redis /www/data/redis
```




#Run
``` 
docker run --name myredis --rm  -p 127.0.0.1:6379:6379 --user $(id -u redis) -itd \
-v /www/data/redis:/var/lib/redis \
-v /mydata/code/docker/redis/local/conf/redis.conf:/usr/local/etc/redis/redis.conf \
registry.cn-hangzhou.aliyuncs.com/zander84/myredis:3.2.11
```


#DOC
```
https://hub.docker.com/_/redis?tab=description&page=7
```

#进入虚拟机
```
docker container exec -it /myredis:3.2.11 bash
```
