## Init
```
id www ||  useradd -r -M -s /sbin/nologin www
```


### Build
Prod:
```
docker build --build-arg ENV_PROD=prod  ./ -t php:v7.3.7
```
Dev:
```
docker build --build-arg ENV_PROD=dev  ./ -t php:v7.3.7
```


### Running
To simply run the container:
```
docker container run --name php-fpm --rm -it -p 9000:9000 --user $(id -u www)  php:v7.3.7
```
