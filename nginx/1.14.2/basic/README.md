#宿主机添加www用户
```
id www ||  useradd -r -M -s /sbin/nologin www
```

#启动方式1：加载外部配置文件
```
docker container run  --name mynginx -itd --network host -P --user $(id -u www) --rm --privileged \
-v /code/:/code/ \
-v /code/docker/nginx/local/conf/conf.d:/www/server/nginx/conf/conf.d/   \
-v /code/docker/nginx/local/conf/ssl:/www/server/nginx/conf/ssl/   \
-v /code/docker/nginx/local/conf/nginx.conf:/www/server/nginx/conf/nginx.conf   \
registry.cn-hangzhou.aliyuncs.com/zander84/mynginx:v1.14.2
```


