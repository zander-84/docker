#宿主机添加www用户
```
id www ||  useradd -r -M -s /sbin/nologin www
```

```
docker build   ./ -t registry.cn-hangzhou.aliyuncs.com/zander84/myphp:v7.3.13
```

#启动方式1：加载外部配置文件
```
docker container run  --name myphp-fmp -itd --network host -P    --rm \
-v /www/cc:/code2/   \
-v /code/:/code/   \
-v /code/docker/php/7.3.13/prod/www.conf:/www/server/php/etc/php-fpm.d/www.conf   \
-v /code/docker/php/7.3.13/prod/php.ini:/www/server/php/conf/php.ini   \
--privileged \
registry.cn-hangzhou.aliyuncs.com/zander84/myphp:v7.3.13
```


#启动方式2：内置dev|prod环境
```
docker container run  --name myphp-fmp -itd --network host -P -e ENV="dev" --user $(id -u www)  --rm  \
-v /code/:/code/   \
registry.cn-hangzhou.aliyuncs.com/zander84/myphp:v7.3.12
```


#进入虚拟机
```
docker container exec -it myphp-fmp bash
```


