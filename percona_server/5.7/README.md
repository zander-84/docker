#宿主机添加www用户
```
id mysql || useradd  -r -s /sbin/nologin -M  mysql

[ -d /www/data/percona_server/data ] || mkdir /www/data/percona_server/data -pv  && \
[ -d /www/data/percona_server/log-bin ] || mkdir /www/data/percona_server/log-bin -pv  && \
[ -d /www/data/percona_server/logs ] || mkdir /www/data/percona_server/logs -pv  && \
chown -R mysql:mysql /www/data/percona_server/ 
```




#Run
```
docker run --name percona_server \
-v /www/data/percona_server/:/www/data/mysql/ \
-v /code/docker/percona_server/5.7/conf/my.cnf:/etc/mysql/my.cnf \
-p 3306:3306 --user $(id -u mysql) --rm  \
-d percona/percona-server:5.7.26
```

#First Run
```
docker run --name percona_server \
-v /www/data/percona_server/:/www/data/mysql/ \
-v /code/docker/percona_server/5.7/conf/my.cnf:/etc/mysql/my.cnf \
-p 3306:3306 --user $(id -u mysql) --rm  \
-e MYSQL_ROOT_PASSWORD=123456  \
-d percona/percona-server:5.7.26
```


#DOC
```https://hub.docker.com/r/percona/percona-server```

#进入虚拟机
```
[root@node1 ~]# docker exec -it  percona-server bash
$ mysql -u root -h 127.0.0.1 -p
$ mysql -u root -h localhost -S /tmp/mysql.sock -p
```
