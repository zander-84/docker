
#DOC
```https://hub.docker.com/_/composer

```

#CMD   注意$PWD
```
eval $(ssh-agent); \
docker run --rm -it \
--volume $SSH_AUTH_SOCK:/ssh-auth.sock \
--env SSH_AUTH_SOCK=/ssh-auth.sock \
--volume ${COMPOSER_HOME:-$HOME/.composer}:/tmp \
--volume $PWD:/app \
composer update


```

#USER
```
--user $(id -u www) \
```
