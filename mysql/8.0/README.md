#宿主机添加www用户
```
id mysql || useradd  -r -s /sbin/nologin -M  mysql

[ -d /www/data/mysql8/data ] || mkdir /www/data/mysql8/data -pv  && \
[ -d /www/data/mysql8/log-bin ] || mkdir /www/data/mysql8/log-bin -pv  && \
[ -d /www/data/mysql8/logs ] || mkdir /www/data/mysql8/logs -pv  && \
chown -R mysql:mysql /www/data/mysql8/ 
```




#Run
```
docker run --name mysql8 \
-v /www/data/mysql8/:/www/data/mysql/ \
-v /code/docker/mysql/8.0/conf/my.cnf:/etc/mysql/my.cnf \
-p 3306:3306 --user $(id -u mysql) --rm  \
-d mysql:8.0
```

#First Run
```
docker run --name mysql8 \
-v /www/data/mysql8/:/www/data/mysql/ \
-v /code/docker/mysql/8.0/conf/my.cnf:/etc/mysql/my.cnf \
-e MYSQL_ROOT_PASSWORD=123456  \
-p 3306:3306 --user $(id -u mysql) --rm  \
-d mysql:8.0
```


#DOC
```https://hub.docker.com/_/mysql?tab=description```

#进入虚拟机
```
[root@node1 ~]# docker exec -it mysql8 bash
$ mysql -u root -h 127.0.0.1 -p
$ mysql -u root -h localhost -S /tmp/mysql.sock -p
```
