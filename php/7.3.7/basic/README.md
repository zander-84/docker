## Init
```
id www ||  useradd -r -M -s /sbin/nologin www;
sysctl vm.nr_hugepages=512;
```


### Build
Prod:
```
docker build   ./ -t php:v7.3.7
```

### Running
To simply run the container:
```
docker container run -e ENV=[dev|prod] --name php-fpm --rm -it -p 9000:9000 --user $(id -u www)  php:v7.3.7
```
