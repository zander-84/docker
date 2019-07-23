## Init
```
id www ||  useradd -r -M -s /sbin/nologin www
```


### Build
Prod:
```
docker build   ./ -t php:v7.3.7
```

### Running
To simply run the container:
```
docker container run -e ENV_PROD=[dev|prod] --name php-fpm --rm -it -p 9000:9000 --user $(id -u www)  php:v7.3.7
```
