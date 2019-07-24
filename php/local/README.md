#宿主机添加www用户
```
id www ||  useradd -r -M -s /sbin/nologin www
```

#启动方式1：加载外部配置文件
```
docker container run  --name myphp-fmp -itd --network host -P  --user $(id -u www) \
-v /mydata/code/:/mydata/code/   \
-v /mydata/code/docker/php/local/php-fpm.d:/www/server/php/etc/php-fpm.d   \
-v /mydata/code/docker/php/local/conf:/www/server/php/conf   \
registry.cn-hangzhou.aliyuncs.com/zander84/myphp:v7.3.7
```


#启动方式2：内置dev|prod环境
```
docker container run  --name myphp-fmp -itd --network host -P -e ENV="dev" --user $(id -u www) \
-v /mydata/code/:/mydata/code/   \
registry.cn-hangzhou.aliyuncs.com/zander84/myphp:v7.3.7
```


#进入虚拟机
```
docker container exec -it myphp-fmp bash
```




