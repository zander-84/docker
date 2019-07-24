#宿主机添加www用户
```
id mysql || useradd  -r -s /sbin/nologin -M  mysql

[ -d /www/data/mysql/data ] || mkdir /www/data/mysql/data -pv  && \
[ -d /www/data/mysql/log-bin ] || mkdir {data_path}/mysql/log-bin -pv  && \
[ -d /www/data/mysql/logs ] || mkdir /www/data/mysql/logs -pv  && \
chown -R mysql:mysql /www/data/mysql/ 
```




#Run
```
docker run --name mysql \
-v /www/data/mysql2/:/www/data/mysql/ \
-v /mydata/code/docker/mysql/5.7.27/local/conf/my.cnf:/etc/mysql/my.cnf \
-p 3306:3306 --user $(id -u mysql) \
-d mysql:5.7.27
```


#DOC
```https://hub.docker.com/_/mysql?tab=description```
