#宿主机添加www用户
```
id www ||  useradd -r -M -s /sbin/nologin www
```
###启动
```
docker container run  --name mynginx -itd --network host -P --user $(id -u www)   \
-v /mydata/code/:/mydata/code/ \
-v /mydata/code/docker/nginx/local/conf/conf.d:/www/server/nginx/conf/conf.d/   \
-v /mydata/code/docker/nginx/local/conf/ssl:/www/server/nginx/conf/ssl/   \
registry.cn-hangzhou.aliyuncs.com/zander84/mynginx:v1.14.2
```

#外部进入
```
docker container exec -it mynginx bash
```

###重启
```
docker container exec -it mynginx /www/server/nginx/sbin/nginx -t
docker container exec -it mynginx /www/server/nginx/sbin/nginx -s reload
```



